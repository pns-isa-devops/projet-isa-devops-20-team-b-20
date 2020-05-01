def results = ""
pipeline{
    agent any
    options {
        disableConcurrentBuilds()
        timeout(time: 1, unit: "HOURS")
    }
    stages {
        stage("build") {
            steps {
                dir('./docker/') {
                    sh '''
                        chmod +x                                                         \
                                ./build-test.sh                                           \
                                ../projet-isa-devops-20-team-b-20-carrier-api/compile.sh \
                                ../projet-isa-devops-20-team-b-20-drone-api/compile.sh
                    '''
                    sh "./build-test.sh"
                }
            }
        }
        stage("integration tests") {

            stages {
                stage("schedule and make a delivery") {
                    environment {
                        TEST_NAME = 'schedule_and_make_a_delivery'
                    }
                    stages {
                        stage("Docker up test Env") {
                            steps {
                                dir('./docker/env/test/') {
                                    echo "docker env up"
                                    sh "docker-compose -f docker-compose.yml up -d --build"
                                }
                            }
                        }
                        stage("Proceed with the test") {
                            steps {
                                echo "run integration test on [${TEST_NAME}]"
                                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                    sh '''
                                        sg docker -c "docker wait dd-integration-tests > ${TEST_NAME}.txt"
                                        exit "$(cat ${TEST_NAME}.txt)"
                                    '''
                                }
                            }
                            post {
                                success {
                                    script {
                                        results += "\n[${TEST_NAME}] : SUCCESS"
                                    }
                                }
                                failure {
                                    script {
                                        results += "\n[${TEST_NAME}] : FAILURE"
                                    }
                                }
                            }
                        }
                        stage("Docker down test Env") {
                            steps {
                                dir('./docker/env/test/') {
                                    sh "docker-compose -f docker-compose.yml down"
                                    echo "docker env down"
                                }
                            }
                        }
                    }
                }
            }

        }
        stage("Verify the results") {
            steps {
                script {
                    if(results.contains("FAILURE")) {
                        exit 1
                    }
                }
            }
        }
    }
    post{
        success {
            slackSend(
            channel: 'projet-isa-devops-ci',
            notifyCommitters: true,
            failOnError: true,
            color: 'good',
            token: env.SLACK_TOKEN,
            message: 'Job: ' + env.JOB_NAME + ' with buildnumber ' + env.BUILD_NUMBER + ' was successful' + "\nIntegration tests : " + results,
            baseUrl: env.SLACK_WEBHOOK)
            echo "======== pipeline executed successfully ========"
        }
        failure {
            slackSend(
            channel: 'projet-isa-devops-ci',
            notifyCommitters: true,
            failOnError: true,
            color: 'danger',
            token: env.SLACK_TOKEN,
            message: 'Job: ' + env.JOB_NAME + ' with buildnumber ' + env.BUILD_NUMBER + ' was failed' + "\nIntegration tests : " + results,
            baseUrl: env.SLACK_WEBHOOK)
            echo "======== pipeline execution failed========"
        }
    }
}

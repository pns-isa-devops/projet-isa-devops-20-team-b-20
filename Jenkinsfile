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
                                ./build-all.sh                                           \
                                ../projet-isa-devops-20-team-b-20-carrier-api/compile.sh \
                                ../projet-isa-devops-20-team-b-20-drone-api/compile.sh
                    '''
                    sh "./build-all.sh"
                }
            }
        }
        stage("integration tests") {
            stages {
                stage("schedule and make a delivery") {
                    steps {
                        echo "run integration test on [schedule and make a delivery]"
                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            dir('./projet-isa-devops-20-team-b-20-client/') {
                                echo "docker env up"
                                sh "docker-compose -f ./docker/docker-compose.yml up -d --build"
                                sh "mvn integration-test -Dcucumber.options=src/test/resources/features/schedule_and_make_a_delivery.feature"
                                sh "docker-compose -f docker/docker-compose.yml down"
                                echo "docker env down"
                            }
                        }
                    }
                    post {
                        success {
                            script {
                                results += "\n[schedule and make a delivery] : SUCCESS"
                            }
                        }
                        failure {
                            script {
                                results += "\n[schedule and make a delivery] : FAILURE"
                            }
                        }
                    }
                }
                // stage("other test...") {
                //     steps {
                //         echo "other test here"
                //     }
                //     post {
                //         success {
                //             script {
                //                 results += "\n[other] : SUCCESS"
                //             }
                //         }
                //         failure {
                //             script {
                //                 results += "\n[other] : FAILURE"
                //             }
                //         }
                //     }
                // }
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
            message: 'Job: ' + env.JOB_NAME + ' with buildnumber ' + env.BUILD_NUMBER + ' was successful' + "\nIntegration tests : " + results,
            baseUrl: env.SLACK_WEBHOOK)
            echo "======== pipeline execution failed========"
        }
    }
}

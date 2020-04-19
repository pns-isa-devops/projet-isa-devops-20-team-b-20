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
        stages {
            stage("docker up") {
                steps {
                        sh "docker-compose -f ./docker/docker-compose.yml up -d --build"
                }
            }
            stage("schedule and make a delivery") {
                steps {
                    echo "run integration test"
                    dir('./projet-isa-devops-20-team-b-20-client/') {
                        sh "mvn integration-test -Dcucumber.options=src/test/resources/features/schedule_and_make_a_delivery.feature"
                    }
                }
            }
            stage("docker down") {
                steps {
                        sh "docker-compose -f docker/docker-compose.yml down"
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
            message: 'Job: ' + env.JOB_NAME + ' with buildnumber ' + env.BUILD_NUMBER + ' was successful',
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
            message: 'Job: ' + env.JOB_NAME + ' with buildnumber ' + env.BUILD_NUMBER + ' was failed',
            baseUrl: env.SLACK_WEBHOOK)
            echo "======== pipeline execution failed========"
        }
    }
}

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
                    sh './build-all.sh'
                }
            }
        }
        stage("docker up") {
           steps {
                sh "sg docker -c 'docker-compose -f ./docker/docker-compose.yml up -d --build'"
           }
        }
        stage("do somethine") {
            steps {
                echo "do something here"
            }
        }
        stage("docker down") {
           steps {
                sh "sg docker -c 'docker-compose -f docker/docker-compose.yml down'"
           }
        }
    }
    post{
        success {
            echo "======== pipeline executed successfully ========"
        }
        failure {
            echo "======== pipeline execution failed========"
        }
    }
}

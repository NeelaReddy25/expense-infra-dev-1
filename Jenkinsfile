pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
        choice(name:'action', choices:['Apply', 'Destroy'], description:'pick something')
    }
    stages {
        stage('Init') {
            steps {
                sh """
                cd 01-vpc
                terraform init -reconfigure
                """
            }
        }
        stage('Plan') {
            steps {
                sh """
                cd 01-vpc
                terraform plan
                """
            }
        }
        stage('Deploy') {
            input {
                message "should we continue?"
                ok "Yes, we should."
            }
            steps {
                sh """
                cd 01-vpc
                terraform apply -auto-approve
                """
            }
        }
    }
    post {
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success {
            echo 'I will run when pipeline is Success'
        }
        failure {
            echo 'I will run when pipeline is Failure'
        }
    }
}
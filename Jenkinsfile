pipeline {
    agent any

    environment {
        DOCKER = "C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe"
        IMAGE_NAME = "demoapp:latest"
        CONTAINER_NAME = "demoapp-container"
        HOST_PORT = "9090"
        CONTAINER_PORT = "8080"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "\"%DOCKER%\" build -t %IMAGE_NAME% ."
            }
        }

        stage('Stop Old Container') {
            steps {
                bat """
                \"%DOCKER%\" stop %CONTAINER_NAME% 2>NUL || echo Container not running
                \"%DOCKER%\" rm %CONTAINER_NAME% 2>NUL || echo Container not found
                """
            }
        }

        stage('Run New Container') {
            steps {
                bat "\"%DOCKER%\" run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%"
            }
        }
    }

    post {
        success {
            echo '✅ Docker CI/CD deployment successful'
        }
        failure {
            echo '❌ Docker CI/CD deployment failed'
        }
    }
}

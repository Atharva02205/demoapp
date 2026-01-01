pipeline {
    agent any

    environment {
        IMAGE_NAME = "demoapp:latest"
        CONTAINER_NAME = "demoapp-container"
        HOST_PORT = "9090"
        CONTAINER_PORT = "8080"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Atharva02205/demoapp.git'
            }
        }

        stage('Build JAR') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat '"C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" build -t %IMAGE_NAME% .'
            }
        }

        stage('Stop Old Container') {
            steps {
                bat '''
                "C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" stop %CONTAINER_NAME% 2>NUL || echo Container not running
                "C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" rm %CONTAINER_NAME% 2>NUL || echo Container not found
                '''
            }
        }

        stage('Run New Container') {
            steps {
                bat '''
                "C:\\Program Files\\Docker\\Docker\\resources\\bin\\docker.exe" run -d -p %HOST_PORT%:%CONTAINER_PORT% --name %CONTAINER_NAME% %IMAGE_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo 'Docker deployment successful'
        }
        failure {
            echo 'Docker deployment failed'
        }
    }
}

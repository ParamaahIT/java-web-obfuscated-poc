pipeline {
    agent any

    environment {
        IMAGE_NAME = "java-web-poc-obf"
        CONTAINER_NAME = "java-web-poc-container"
        PORT = "8081"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ParamaahIT/java-web-poc.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh """
                        docker build -t $IMAGE_NAME .
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh """
                        docker run -d --name $CONTAINER_NAME -p $PORT:$PORT $IMAGE_NAME
                    """
                }
            }
        }
    }


}

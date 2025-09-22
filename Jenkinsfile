pipeline {
    agent any

    environment {
        IMAGE_NAME = "java-web-poc-obf"
        CONTAINER_NAME = "java-web-poc-container"
        PORT = "8081"
		IMAGE_NAME = 'prashanth2paramaah/hello-world-app:latest'
        VAULT_CRED_ID = 'vault-approle-creds'
        VAULT_ADDR    = 'http://52.72.235.53:8200'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ParamaahIT/java-web-obfuscated-poc.git'
            }
        }
        stage('Docker Login') {
            steps {
              script {
                withVault(
                  vaultUrl: "${env.VAULT_ADDR}",
                  vaultCredentialId: "${env.VAULT_CRED_ID}",
                  vaultSecrets: [
                   [
                     path: 'secret/docker-credentials',    
                     engineVersion: 2,
                     secretValues: [
                       [envVar: 'DOCKER_USERNAME', vaultKey: 'username'],
                       [envVar: 'DOCKER_PASSWORD', vaultKey: 'password']
                     ]
                   ]
                 ]
               ) {
                 sh '''
                   echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

                 '''
               }
             }
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


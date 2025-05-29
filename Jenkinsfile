pipeline {
    agent any

    environment {
        // gfgfgfg
        IMAGE_NAME = "sooyaa02/apiimages"
    }

    stages {
        stage('Clone source code') {
            steps {
                git branch: 'dev', url: 'https://github.com/kitsanaphon1/api-images.git'
            }
        }

        stage('Build Docker image') {
            steps {
                sh "docker build --network=host -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: '12345',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }
    }
}

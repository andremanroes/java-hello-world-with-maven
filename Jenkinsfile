pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def app = docker.build("helloworld-java-app:${env.BUILD_NUMBER}")
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh 'eval $(minikube -p minikube docker-env) && kubectl apply -f k8s/deployment.yaml'
            }
        }

        stage('Simulate Update') {
            steps {
                sh 'sed -i "s/Hello World Version 1/Hello World Version 2/g" src/main/resources/application.properties'
                sh 'mvn package'
                sh 'eval $(minikube -p minikube docker-env) && kubectl rollout restart deployment/helloworld-java-app'
            }
        }
    }
}

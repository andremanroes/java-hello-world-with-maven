pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'hello-world-app:latest'
        K8S_NAMESPACE = 'hello-world-app'
        K8S_DEPLOYMENT = 'hello-world-deployment'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
                sh 'docker tag $DOCKER_IMAGE my-docker-registry/$DOCKER_IMAGE'
                sh 'docker push my-docker-registry/$DOCKER_IMAGE'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    kubernetesDeploy(
                        kubeconfigId: 'my-kubeconfig',
                        configs: 'path/to/kube/config.yml',
                        enableConfigSubstitution: false,
                        namespace: "$K8S_NAMESPACE",
                        deploymentName: "$K8S_DEPLOYMENT",
                        replicas: 3,
                        imagePullSecrets: 'my-registry-secret',
                        containers: [
                            containerTemplate(
                                name: 'hello-world-app',
                                image: "$DOCKER_IMAGE",
                                ports: [
                                    containerPort(8080)
                                ]
                            )
                        ]
                    )
                }
            }
        }
    }
}

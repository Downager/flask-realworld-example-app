pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest -f ./unittest_dockerfile .'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

    stage('Build') {
      environment {
        DOCKER_HUB_CREDS = 'credentials(\'dockerhub-downager\')'
      }
      steps {
        sh '''
docker login
-u $DOCKER_HUB_CRED_USR -p $DOCKER_HUB_CRED_PSW'''
      }
    }

  }
}
pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest -f ./unittest_dockerfile .'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

    stage('Build and Push') {
      steps {
        sh '''
docker login
-u downager -p Password
docker build -t downager/flask-realworld-example-app:latest .
docker push downager/flask-realworld-example-app:latest'''
      }
    }

  }
}
pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest -f ./unittest_dockerfile'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

  }
}
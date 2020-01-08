pipeline {
  agent none
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest .'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

  }
}
pipeline {
  agent {
    docker {
      image 'python:3.7'
    }

  }
  stages {
    stage('Test') {
      steps {
        sh 'pip install -r requirements/dev.txt'
        sh 'flask test'
      }
    }

  }
  environment {
    FLASK_APP = 'autoapp.py'
    FLASK_DEBUG = '1'
  }
}
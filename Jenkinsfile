pipeline {
  agent none
  stages {
    stage('Unit Test') {
      agent {
        docker {
          image 'python:3.7'
        }

      }
      steps {
        sh '''pip install -r requirements/dev.txt

'''
        sh 'flask test'
      }
    }

  }
}
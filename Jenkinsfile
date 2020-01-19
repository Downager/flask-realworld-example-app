pipeline {
  agent any
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest -f ./UnitTest_Dockerfile .'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

    stage('Build') {
      environment {
        DOCKER_HUB_CREDS = credentials('dockerhub-downager')
      }
      steps {
        sh 'docker login -u $DOCKER_HUB_CREDS_USR -p $DOCKER_HUB_CREDS_PSW'
        sh 'docker build -t downager/flask-realworld-example-app:$GIT_COMMIT .'
        sh 'docker push downager/flask-realworld-example-app:$GIT_COMMIT'
      }
    }
    stage('Deploy_To_Stagging') {
        steps {
            echo 'Deploy to stagging environment "flask-realworld-example-app:$GIT_COMMIT"'
        }
    }
    stage('Deploy_To_Production') {
        when { tag "*" }
        steps {
            echo 'Deploying only because this commit is tagged...'
            sh 'docker tag downager/flask-realworld-example-app:$GIT_COMMIT'
        }
    }
  }
}
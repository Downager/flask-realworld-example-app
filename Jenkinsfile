pipeline {
  agent any
  environment {
    DOCKER_HUB_CREDS = credentials('dockerhub-downager')
  }
  stages {
    stage('Test') {
      steps {
        sh 'docker build -t flask-realworld-example-app:UnitTest -f ./UnitTest_Dockerfile .'
        sh 'docker run flask-realworld-example-app:UnitTest'
      }
    }

    stage('Build') {
      steps {
        sh 'docker login -u $DOCKER_HUB_CREDS_USR -p $DOCKER_HUB_CREDS_PSW'
        sh 'docker build -t downager/flask-realworld-example-app:$GIT_COMMIT .'
        sh 'docker push downager/flask-realworld-example-app:$GIT_COMMIT'
        sh 'docker system prune -f'
      }
    }

    stage('Deploy - Stagging') {
      environment {
        HOST_GROUP = 'Stagging'
      }
      steps {
        dir(path: 'ansible') {
          ansiColor(colorMapName: 'xterm') {
            ansiblePlaybook(
              credentialsId: 'devops-ssh-key',
              playbook: 'playbook-deploy-flask-app.yml',
              inventory: 'hosts',
              colorized: true)
          }
        }
      }
    }

    stage('Deploy - Production') {
      when {
        tag '*'
      }
      environment {
        HOST_GROUP = 'Production'
      }
      steps {
        echo 'Deploying only because this commit is tagged...'
        sh 'docker tag downager/flask-realworld-example-app:$GIT_COMMIT downager/flask-realworld-example-app:$TAG_NAME'
        sh 'docker push downager/flask-realworld-example-app:$TAG_NAME'
      }
    }
  }
}
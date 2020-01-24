pipeline {
  agent any
  environment {
    DOCKER_HUB_CREDS = credentials('dockerhub-downager')
    FLASK_POSTGRES_CREDS = credentials('flask-app-postgres-user-pass')
    DB_MIGRATION = false
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

    stage('Deploy - Staging') {
      environment {
        HOST_GROUP = 'Staging'
        IMAGE_TAG = sh(returnStdout: true, script: 'echo $GIT_COMMIT')
      }
      steps {
        echo 'Deploy to staging servers'
        ansiColor(colorMapName: 'xterm') {
          ansiblePlaybook(
            disableHostKeyChecking: true,
            credentialsId: 'devops-ssh-key',
            playbook: 'ansible/playbook-deploy-flask-app.yml',
            inventory: 'ansible/hosts',
            colorized: true)
        }
        echo 'Make a smoke testing on staging servers (MAX_RETRIES = 3)'
        retry(3) {
          ansiColor(colorMapName: 'xterm') {
            ansiblePlaybook(
              disableHostKeyChecking: true,
              credentialsId: 'devops-ssh-key',
              playbook: 'ansible/playbook-smoke-testing.yml',
              inventory: 'ansible/hosts',
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
        HOST_GROUP = 'Stagging'
        IMAGE_TAG = sh(returnStdout: true, script: 'echo $TAG_NAME')
      }
      steps {
        echo 'Deploying only because this commit is tagged...'
        sh 'docker tag downager/flask-realworld-example-app:$GIT_COMMIT downager/flask-realworld-example-app:$TAG_NAME'
        sh 'docker push downager/flask-realworld-example-app:$TAG_NAME'
      }
    }
  }
}
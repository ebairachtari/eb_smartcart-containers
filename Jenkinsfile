pipeline {
  agent any

  stages {
    stage('Build containers') {
      steps {
        sh 'docker-compose build'
      }
    }

    stage('Run containers') {
      steps {
        sh 'docker-compose up -d'
        sh 'sleep 10'
      }
    }

    stage('Test backend login') {
      steps {
        sh '''
        curl -X POST http://localhost:5000/auth/login \
        -H "Content-Type: application/json" \
        -d '{"email": "demo_user@unipi.gr", "password": "qqQQ11!!"}'
        '''
      }
    }

    stage('Test ML Service') {
      steps {
        sh '''
        curl -X POST http://localhost:5001/predict \
        -H "Content-Type: application/json" \
        -d '{"basket": [1, 0]}'
        '''
      }
    }

    stage('Stop containers') {
      steps {
        sh 'docker-compose down'
      }
    }
  }
}

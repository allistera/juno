pipeline {
  agent {
    docker {
      image 'ruby'
    }
    
  }
  stages {
    stage('error') {
      steps {
        sh 'bundle install'
      }
    }
  }
}
pipeline {
  agent {
    docker {
      image 'ruby'
    }
    
  }
  stages {
    stage('error') {
      agent {
        docker {
          image 'ruby'
        }
        
      }
      steps {
        sh 'bundle install'
      }
    }
  }
}
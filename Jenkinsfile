pipeline {
  agent { dockerfile true }
  stages {
      stage('Git Checkout') {
        steps {
          git branch: 'main', url: 'https://github.com/Ajaytekam/testrepo.git'
        }
      }

      stage('Unit Testing') {
        steps {
            sh 'mvn test'
        }
      }
 
      stage('Integration Testing') {
        steps {
            sh 'mvn verify -DskipUnitTests'
        }
      }

      stage('Maven Build') {
         steps {
            sh 'mvn clean install -DskipTests'
         }

         post {
           success {
             echo 'Now archiving it...'
             archiveArtifacts artifacts: '**/target/*.war'
           }
         }
      }

      stage('Checkstyle Analysis') {
        steps {
            sh 'mvn checkstyle:checkstyle'
        }
      }

  }  
}

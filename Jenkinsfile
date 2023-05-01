pipeline {
  agent { dockerfile true }
  stages {
      stage('Git Checkout') {
        steps {
          git branch: 'main', url: 'https://github.com/Ajaytekam/testrepo.git'
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

      stage('Some Tests') {
          steps {
              sh '''ls -al;
                    whoami;
                    pwd;
              '''
          }
      }
  }  
}

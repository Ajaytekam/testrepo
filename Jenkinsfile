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

      agent none
      stage('Docker ImageBuild') {
        steps {
            // sh 'docker image build -t vprofileapp:latest . -f Dockerfile01'
            sh 'docker --help'
        }
      }  
  }
}

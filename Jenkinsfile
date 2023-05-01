pipeline {

  agent {
    docker {
      image 'ajaytekam/java-builder:latest'
      reuseNode true                                                                          
    }
  }

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

      stage('Docker ImageBuild') {
          agent {
            docker {
              image 'docker:latest'
              args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
            }
          }
        steps {
            // sh 'docker image build -t vprofileapp:latest . -f Dockerfile01'
            sh 'docker --help'
        }
      }  
  }
}

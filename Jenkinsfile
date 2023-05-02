pipeline {
  
  agent any

  environment {
    DOCKERHUB_CREDENTIALS=credentials('dockerhub-creds')   
  }

  stages {
      stage('Git Checkout') {
        steps {
          git branch: 'main', url: 'https://github.com/Ajaytekam/testrepo.git'
        }
      }

      stage('Unit Testing') {
         
        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                      
            }
        }

        steps {
            sh 'mvn test'
        }
      }
 
      stage('Integration Testing') {

        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                       
            }
        }

        steps {
            sh 'mvn verify -DskipUnitTests'
        }
      }
      
      stage('Maven Build') {

        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                       
            }
        }
          
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

        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                       
            }
        }

        steps {
            sh 'mvn checkstyle:checkstyle'
        }
      }

    stage('SonarQube Code Analysis') {

        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                       
            }
        }

        steps {
            script {
                withSonarQubeEnv(credentialsId: 'sonar-token') { 
                  sh '''sonar-scanner -X \
                        -Dsonar.projectKey=vprofile \
                        -Dsonar.projectName=vprofile \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/ \
                        -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                  '''
                }
            }
        }
    }

    stage('SonarQube QualityGate Status') {

        agent {
            docker {
              image 'ajaytekam/java-builder:latest'
              reuseNode true                                                       
            }
        }

      steps{
        timeout(time: 1, unit: 'HOURS') {
            // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
            // true = set pipeline to UNSTABLE, false = don't
            //waitForQualityGate abortPipeline: true
            waitForQualityGate abortPipeline: true, credentialsId: 'sonar-token'  
        }
      }
    }

    stage('Docker ImageBuild') {
      steps {
        sh 'docker image build -t ajaytekam/vprofileappimg:latest .'
      }
    }  

    stage('Push Image into Dockerhub') {
       
      steps {
        // login to dockerhub 
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        // push the docker image 
        sh 'docker push ajaytekam/vprofileappimg:latest'
      }

      post {
          always {
              sh 'docker logout'
          }
      }
    }

  }  
}

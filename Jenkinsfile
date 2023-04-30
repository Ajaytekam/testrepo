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

    stage('SonarQube Code Analysis') {

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

  }  
}

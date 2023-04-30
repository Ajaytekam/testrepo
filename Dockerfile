FROM openjdk:8
RUN apt update && apt install maven unzip wget -y
RUN mkdir /sonarqube
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip -O /sonarqube/sonar.zip
RUN cd /sonarqube && unzip sonar.zip && rm sonar.zip
ENV PATH="${PATH}:/sonarqube/sonar-scanner-4.8.0.2856-linux/bin"

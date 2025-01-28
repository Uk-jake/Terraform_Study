#!/bin/bash
set -e  # 스크립트 실행 중 오류 발생 시 종료

# 실행 중인 JAR 프로세스 종료
# echo "Checking for running application..."
# RUNNING_JAR=$(ps -ef | grep demo-0.0.1-SNAPSHOT.jar | grep -v grep | awk '{print $2}')

# if [ -n "$RUNNING_JAR" ]; then
#   echo "Found running application with PID: $RUNNING_JAR. Stopping it..."
#   kill -9 "$RUNNING_JAR"
#   echo "Application stopped."
# else
#   echo "No running application found."
# fi

# Java 설치 확인 및 설치
if ! java --version &> /dev/null; then
  echo "Java is not installed. Installing Java..."
  sudo apt-get update
  sudo apt-get install -y openjdk-17-jdk
else
  echo "Java is already installed."
fi

# Java 버전 확인
java --version

# 기존 디렉토리 삭제
rm -rf my-app-terraform

# git clone
git clone https://github.com/Nanninggu/my-app-terraform.git
cd my-app-terraform

# Gradle 빌드
chmod +x gradlew
./gradlew build

# 빌드된 Jar 파일 확인
if [ -f /home/ubuntu/my-app-terraform/build/libs/demo-0.0.1-SNAPSHOT.jar ]; then
  echo "JAR file found. Starting application..."
  nohup java -jar /home/ubuntu/my-app-terraform/build/libs/demo-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
  echo "Application is running in the background with PID $!"
else
  echo "Error: JAR file not found. Build might have failed."
  exit 1
fi

# 애플리케이션 로그 확인 안내
echo "To view logs, use: tail -f app.log"

# Java 설치
sudo apt-get update
sudo apt-get install openjdk-17-jdk -y

# Java 버전 확인
java -version

# 기존 디렉토리 삭제
rm -rf my-app-terraform

# git clone 
git clone https://github.com/Nanninggu/my-app-terraform.git
cd my-app-terraform

# Gradle 빌드
chmod +x gradlew

./gradlew build

# 빌드된 Jar 파일 실행
java -jar build/libs/my-app-0.0.1-SNAPSHOT.jar
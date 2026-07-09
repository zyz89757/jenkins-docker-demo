pipeline {
    agent any
    stages {
        stage('创建文件') {
            steps {
                sh 'echo "这是我第一次用 Jenkins 构建成功的证据！构建编号：$BUILD_NUMBER" > hello.txt'
            }
        }
        stage('归档文件') {
            steps {
                archiveArtifacts artifacts: 'hello.txt', fingerprint: true
            }
        }
    }
}

pipeline {
    agent any 
    stages {
        stage('1. 拉取代码') {
            steps {
                echo 'Code has been checked out.'
            }
        }
        stage('2. 构建镜像') {
            steps {
                script {
                    // 在Jenkins容器内构建Docker镜像，标签为 my-app:latest
                    sh 'docker build -t my-app:latest .'
                }
            }
        }
        stage('3. 清理旧容器与镜像') {
            steps {
                script {
                    // 强制删除可能存在的旧容器和镜像，防止端口冲突
                    sh 'docker rm -f my-running-app || true'
                    sh 'docker rmi my-app:latest || true'
                }
            }
        }
        stage('4. 部署运行') {
            steps {
                script {
                    // 运行新构建的镜像，并将主机的3000端口映射到容器的3000端口
                    sh 'docker run -d -p 3000:3000 --name my-running-app my-app:latest'
                }
            }
        }
    }
}

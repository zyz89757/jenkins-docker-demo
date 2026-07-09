pipeline {
    agent any
    
    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'test', 'prod'],
            description: '请选择要发布的目标环境'
        )
        string(
            name: 'VERSION',
            defaultValue: 'v1.0.0',
            description: '请输入本次发布的版本号'
        )
    }
    
    environment {
        // ⚠️ 请将下面的 WEBHOOK_URL 替换成你复制的钉钉机器人地址
        DINGTALK_WEBHOOK = 'https://oapi.dingtalk.com/robot/send?access_token=0ff68e0c01964623dc5fc5aa3bfdb2b8f070cfdb00f96efe5f0a54c4dc269c90'
        // 如果开启了加签，取消下面这行的注释，并填上你的密钥
         DINGTALK_SECRET = 'SECfdf9e4453f719f394b8b267972ccc8b2a162d5a5850d6550334155896303d903'
    }
    
    stages {
        stage('选择环境') {
            steps {
                echo "目标环境: ${params.ENV}"
                echo "版本号: ${params.VERSION}"
            }
        }
        
        stage('模拟发布') {
            steps {
                script {
                    // 根据不同环境，创建不同的标识文件
                    def envDir = "/tmp/deploy/${params.ENV}"
                    sh "mkdir -p ${envDir}"
                    writeFile file: "${envDir}/deploy.txt", text: """
                    环境: ${params.ENV}
                    版本: ${params.VERSION}
                    构建编号: ${BUILD_NUMBER}
                    时间: ${new Date().format('yyyy-MM-dd HH:mm:ss')}
                    """
                    echo "✅ 已发布到 ${params.ENV} 环境"
                }
            }
        }
        
        stage('发送钉钉通知') {
            steps {
                script {
                    // 构建通知消息内容
                    def message = """
                    ### ✅ ${params.ENV.toUpperCase()} 环境发布成功
                    - **项目**: jenkins-demo
                    - **版本**: ${params.VERSION}
                    - **构建编号**: ${BUILD_NUMBER}
                    - **时间**: ${new Date().format('yyyy-MM-dd HH:mm:ss')}
                    - **发布人**: ${env.BUILD_USER_ID ?: 'anonymous'}
                    """.stripIndent().trim()
                    
                    // 构造钉钉消息 JSON
                    def json = """{
                        "msgtype": "markdown",
                        "markdown": {
                            "title": "发布通知",
                            "text": "${message}"
                        }
                    }"""
                    
                    // 发送 HTTP 请求到钉钉
                    sh """
                        curl -s -X POST \
                          -H 'Content-Type: application/json' \
                          -d '${json}' \
                          ${DINGTALK_WEBHOOK}
                    """
                }
            }
        }
    }
    
    post {
        failure {
            echo "❌ 构建失败，可以在这里发告警通知"
        }
    }
}

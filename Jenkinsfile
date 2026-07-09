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
        // ⚠️ 请将下面的地址替换成你自己的钉钉机器人 Webhook 地址
        DINGTALK_WEBHOOK = 'https://oapi.dingtalk.com/robot/send?access_token=0ff68e0c01964623dc5fc5aa3bfdb2b8f070cfdb00f96efe5f0a54c4dc269c90'
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
                    def envDir = "/tmp/deploy/${params.ENV}"
                    sh "mkdir -p ${envDir}"
                    writeFile file: "${envDir}/deploy.txt", text: """
                        环境: ${params.ENV}
                        版本: ${params.VERSION}
                        构建编号: ${BUILD_NUMBER}
                        时间: ${new Date().format('yyyy-MM-dd HH:mm:ss')}
                    """.stripIndent().trim()
                    echo "✅ 已发布到 ${params.ENV} 环境"
                }
            }
        }

        stage('发送钉钉通知') {
            steps {
                script {
                    // 构造消息内容，确保包含关键词 "BUILD"
                    def msgText = "### ✅ ${params.ENV.toUpperCase()} 环境发布成功\\nBUILD\\n- **项目**: jenkins-demo\\n- **版本**: ${params.VERSION}\\n- **构建编号**: ${BUILD_NUMBER}\\n- **时间**: ${new Date().format('yyyy-MM-dd HH:mm:ss')}"

                    // 发送请求
                    sh """
                        curl -s -X POST \\
                          -H 'Content-Type: application/json' \\
                          -d '{"msgtype": "markdown", "markdown": {"title": "发布通知", "text": "${msgText}"}}' \\
                          '${DINGTALK_WEBHOOK}'
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

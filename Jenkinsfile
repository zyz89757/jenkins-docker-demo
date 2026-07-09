pipeline {
    agent any
    
    // 参数化构建：每次构建会让你输入一个选项
    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'test', 'prod'],
            description: '请选择要生成报告的环境'
        )
    }
    
    stages {
        stage('生成报告') {
            steps {
                script {
                    // 获取当前时间，格式化为 YYYYMMDD_HHMMSS
                    def timestamp = new Date().format('yyyyMMdd_HHmmss')
                    
                    // 根据用户选择的参数，决定报告内容
                    def envName = params.ENV
                    def reportContent = ''
                    
                    if (envName == 'dev') {
                        reportContent = "【开发环境】日常构建报告 - 构建编号: ${BUILD_NUMBER}"
                    } else if (envName == 'test') {
                        reportContent = "【测试环境】回归测试报告 - 构建编号: ${BUILD_NUMBER}"
                    } else if (envName == 'prod') {
                        reportContent = "【生产环境】发布上线报告 - 构建编号: ${BUILD_NUMBER}"
                    }
                    
                    // 生成 HTML 文件
                    writeFile file: 'report.html', text: """
                    <html>
                    <head><title>${envName} 报告</title></head>
                    <body>
                        <h1>${reportContent}</h1>
                        <p>生成时间: ${timestamp}</p>
                        <p>由 Jenkins 流水线自动生成</p>
                    </body>
                    </html>
                    """
                }
            }
        }
        stage('归档报告') {
            steps {
                archiveArtifacts artifacts: 'report.html', fingerprint: true
            }
        }
    }
}

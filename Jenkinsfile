properties([
    parameters([
        string(defaultValue: 'variables.tfvars', description: 'Specify the file name', name: 'File-Name'),
        choice(choices: ['apply', 'destroy'], description: 'Select Terraform action', name: 'Terraform-Action')
    ])
])

pipeline {
    agent any

    stages {
        stage('Set AWS Credentials') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-admin', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        // Credentials will be available in this block
                        env.AWS_ACCESS_KEY_ID = AWS_ACCESS_KEY_ID
                        env.AWS_SECRET_ACCESS_KEY = AWS_SECRET_ACCESS_KEY
                    }
                }
            }
        }

        stage('Checkout from Git') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[url: 'https://github.com/tyagiharsh7/Stay-Spotter-DevOps.git']]
                ])
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir('terraform') {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Validate Terraform Code') {
            steps {
                dir('terraform') {
                    script {
                        sh 'terraform validate'
                    }
                }
            }
        }
        
        stage('Parameter Validation') {
            steps {
                script {
                    if (!['apply', 'destroy'].contains(params.'Terraform-Action')) {
                        error "Invalid value for Terraform-Action: ${params.'Terraform-Action'}"
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    script {
                        sh "terraform plan -var-file=${params.'File-Name'}"
                    }
                }
            }
        }

        stage('Terraform Apply/Destroy') {
            steps {
                dir('terraform') {
                    script {
                        def terraformCommand = "terraform ${params.'Terraform-Action'} -auto-approve  -var-file=${params.'File-Name'}"
                        sh terraformCommand
                    }
                }
            }
        }
    }
}

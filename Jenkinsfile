pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Hesham-Elngar/registration-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Archive Artifact') {
            steps {
                sh 'pwd'
                sshPublisher(
                    publishers: [
                        sshPublisherDesc(
                            configName: 'Ansible-Server',
                            transfers: [
                                sshTransfer(
                                    cleanRemote: false,
                                    execTimeout: 120000,
                                    flatten: true,
                                    remoteDirectory: '/Docker',
                                    removePrefix: 'webapp/target',
                                    sourceFiles: 'webapp/target/*.war'
                                )
                            ]
                        )
                    ]
                )
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                  sh 'pwd'
                  sh 'ls -l Dockerfile'
                withCredentials([
                    usernameColonPassword(credentialsId: 'DockerHub_creds', variable: 'DockerHub'),
                    string(credentialsId: 'ansible-vault-pass2', variable: 'ANSIBLE_VAULT_PASS')
                ]) {
                    sh '''
                        set -e
                        DOCKER_USER=$(echo $DockerHub | cut -d':' -f1)
                        DOCKER_PASS=$(echo $DockerHub | cut -d':' -f2)

                        echo "$ANSIBLE_VAULT_PASS" > .vault_pass.txt
                        chmod 600 .vault_pass.txt

                        ansible-playbook -i inventory create_image_regapp.yml --vault-password-file .vault_pass.txt \
                          --extra-vars "dockerhub_username=$DOCKER_USER dockerhub_password=$DOCKER_PASS"

                        unset DOCKER_USER DOCKER_PASS
                    '''
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([
                    string(credentialsId: 'ansible-vault-pass2', variable: 'ANSIBLE_VAULT_PASS')
                ]) {
                    sh '''
                        echo "$ANSIBLE_VAULT_PASS" > .vault_pass.txt
                        chmod 600 .vault_pass.txt

                         ansible-playbook -i inventory kube_deploy.yml --vault-password-file .vault_pass.txt
                    '''
                }
            }
        }
    }

    post {
        always {
            // Clean up sensitive files even if pipeline fails
            sh 'rm -f .vault_pass.txt || true'
        }
    }
}

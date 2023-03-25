pipeline{
    agent any
    tools{
        maven 'maven'
    }
    environment {
        dockerusername = credentials('dockerhub-username')
        dockerpassword = credentials('dockerhub-password')
    }
    stages{
        stage('Git pull'){
            steps{
                git branch: 'main', credentialsId: 'git-cred', url: 'https://github.com/CloudHight/Pet-Adoption-Containerisation-Project-Application-Day-Team--06-Feb.git'
            }
        }
        stage('code analysis'){
            steps{
                withSonarQubeEnv('sonar') {
                    sh 'mvn sonar:sonar'  
               }
            }
        }
        stage('build code'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -t daicon001/pipeline:1.0.11 .'
            }
        }
        stage('login to dockerhub'){
            steps{
                sh 'docker login -u $dockerusername -p $dockerpassword'
            }
        }
        stage('push image'){
            steps{
                sh 'docker push $dockerusername/pipeline:1.0.11'
            }
        }
        stage('deploy to QA'){
            steps{
                sshagent(['jenkins-key']) {
                    sh 'ssh -t -t ec2-user@10.0.1.83 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/QAcontainer.yml"'
               }
            }
        }
        stage('slack notification'){
            steps{
                slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to QA sever need approval to deploy PROD Env', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
            }
        }
        stage('Approval'){
            steps{
                timeout(activity: true, time: 5) {
                  input message: 'need approval to deploy to production ', submitter: 'admin'
               }
            }
        }
        stage('deploy to PROD'){
            steps{
               sshagent(['jenkins-key']) {
                    sh 'ssh -t -t ec2-user@10.0.1.83 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/PRODcontainer.yml"'
               }  
            }
        }
    }
    post {
     success {
       slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to PROD Env ', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
     }
     failure {
       slackSend channel: 'jenkins-pipeline', message: 'failed to deploy to PROD Env', teamDomain: 'Fidelaimah', tokenCredentialId: 'slack-cred'
     }
  }

}
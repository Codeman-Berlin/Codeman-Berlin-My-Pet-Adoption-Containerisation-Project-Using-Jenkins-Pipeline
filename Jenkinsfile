pipeline{
    agent any
    tools{
        maven 'maven'
    }
    environment {
        DockerUsername = credentials('Docker_name')
        DockerPassword = credentials('Docker_pass')
    }
    stages{
        stage('Git pull'){
            steps{
                git branch: 'kubernetes', credentialsId: 'git-cred', url: 'https://github.com/CloudHight/Set_5_Pet_Adoption_Application_Team_3.git'
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
                sh 'docker build -t codeman1/codeman_pipeline .'
            }
        }
        stage('login to dockerhub'){
            steps{
                sh 'docker login -u codeman1 -p Alawaiye1@.'
            }
        }
        stage('push image'){
            steps{
                sh 'docker push codeman1/codeman_pipeline'
            }
        }
        stage('deploy to QA'){
            steps{
                sshagent(['jenkins']) {
                    sh 'ssh -t -t ec2-user@10.0.1.95 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/QAcontainer.yml"'
               }
            }
        }
        stage('slack notification'){
            steps{
                slackSend channel: 'jenkinsbuild', message: 'successfully deployed to QA sever need approval to deploy PROD Env', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
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
               sshagent(['jenkins']) {
                    sh 'ssh -t -t ec2-user@10.0.1.95 -o StrictHostKeyChecking=no "ansible-playbook /home/ec2-user/playbooks/PRODcontainer.yml"'
               }  
            }
        }
    }
    post {
     success {
       slackSend channel: 'jenkins-pipeline', message: 'successfully deployed to PROD Env ', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
     }
     failure {
       slackSend channel: 'jenkins-pipeline', message: 'failed to deploy to PROD Env', teamDomain: 'Codeman-devops', tokenCredentialId: 'slack-cred'
     }
  }

}
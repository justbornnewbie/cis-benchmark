pipeline {
    agent{
        label "worker1"
    } 
    stages{
        stage("5.3.2"){
            steps{
                sh '''
                bash 5.3.2.sh
                '''
            }
        }
    }
}
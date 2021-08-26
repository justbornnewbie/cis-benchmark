pipeline {
    agent{
        label "worker1"
    } 
    stages{
        stage("5.3.2"){
            steps{
                sh '''
                cd 5.3.2.sh
                ./5.3.2.sh
                   '''
            }
        }
    }
}
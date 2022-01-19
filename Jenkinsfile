pipeline {
    agent any

    stages {
        stage("Terraform_Build") {
            steps{
                sh '''
                    packer build Packer.json
                    sleep 30
                    aws s3 cp ./manifest.json s3://sergo.manifest/Packer/manifest.json
                '''
            }
        }
    }
}
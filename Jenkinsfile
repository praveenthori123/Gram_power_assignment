pipeline {
    agent any

    environment {
    repoName='thori22/angular'
    imageName="${repoName}:${BUILD_NUMBER}"
   }

    stages {
        stage('Checking node version') {
           steps {
               sh 'node -v'
           }
        }
        stage('Installing the Modules') {
            steps {
                sh '''
                npm install
                '''
            }
        }
        stage('Bulding NodeJs') {
            steps {
                sh 'npm run build --prod'
            }
        }
        stage('Bulding Docker Image') {
          steps {
            sh 'docker build -t ${imageName} .'
          }
      }
        stage('Publishing Docker Image') {
          steps {
              withDockerRegistry(credentialsId: 'c36baa40-8e31-48e5-9586-b848edd66c1b' , url: '') {
                  sh 'docker push ${imageName}'
                  
            }
          }
      }
      stage('Running the container') {
          steps {
              sh '''
                #!/bin/bash
                # Define the container name 
                CONTAINER_NAME="mycontainer"
                
                # Check if the container exists
                if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
                  # Check if the container is running
                  container_status=$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)
                
                  if [[ $container_status == "true" ]]; then
                    # Stop the container
                    docker stop $CONTAINER_NAME
                  fi
                
                  # Remove the container
                  docker rm $CONTAINER_NAME
                fi
                
                
                # Run a new container with the specified image tag
                docker run -itd -p 81:80 --name $CONTAINER_NAME ${imageName}

              '''
          }
      }
    }
}

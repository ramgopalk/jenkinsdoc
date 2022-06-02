
pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhubcred1')
		tag = sh(returnStdout: true, script: "git rev-parse --short=10 HEAD").trim()
		FULL_PATH_BRANCH = "${sh(script:'git name-rev --name-only HEAD', returnStdout: true)}"
        GIT_BRANCH = FULL_PATH_BRANCH.substring(FULL_PATH_BRANCH.lastIndexOf('/') + 1, FULL_PATH_BRANCH.length())

	}

	stages {
	    
	   /* stage('gitclone') {

			steps {
                                git branch: 'featuerUI', url: 'https://github.com/ramgopalk/docker-poc.git'
			}
		}*/
		stage('Build') {

			steps {
				sh 'docker build -t ramgopalkoya/nginxpoc:${GIT_BRANCH} .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {

			steps {
				sh 'docker push ramgopalkoya/nginxpoc:${GIT_BRANCH}'
			}
		}
		
		stage('container') {

			steps {
				sh 'docker run -itd -p 93:80 --name ${tag} ramgopalkoya/nginxpoc:${GIT_BRANCH}'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}

#!groovy

properties([
    buildDiscarder(logRotator(daysToKeepStr: '20', numToKeepStr: '30')),

    pipelineTriggers([
      pollSCM('H/5 * * * *')
    ])
])

node('docker') {
  stage('SCM') {
    checkout scm
  }

  stage('Build and Push') {
    withCredentials([usernamePassword(credentialsId: 'dockerhub-wobscalebot', 
          passwordVariable: 'DOCKER_PASS', 
          usernameVariable: 'DOCKER_USER')]) {

      sh '''#!/bin/bash -ex
        export HOME=${WORKSPACE}
        docker login --username "${DOCKER_USER}" --password "${DOCKER_PASS}" docker.io

        IMAGE="wobscale/mastodon:$(git describe --tags)"

        docker build -t "${IMAGE}" .
        docker push "${IMAGE}"
      '''
    }
  }
}


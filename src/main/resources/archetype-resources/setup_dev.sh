#!/bin/bash

############################################################
# Setup Imixs-Office-Workflow Dev Environment
# 
############################################################

sudo chmod -R 777 docker/deployments/

echo "#############################################"
echo " starting dev enrvionment..."
echo "#############################################"
mvn clean install -Pdebug
cp ./*-app/target/*.war ./docker/deployments/
docker-compose -f docker-compose.yml up
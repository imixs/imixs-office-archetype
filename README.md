# Imixs-Office-Archetype

[Imixs-Office-Workflow](http://www.office-workflow.de) is a powerful and highly customizable workflow application platform. 
Although Imixs-Office-Workflow can be used out of the box as a standard application, it is also possible to create a so-called 
custom build. A custom build inherits all the functionality of the Imixs-Office-Workflow but also provides the ability to add or customize new features. 

The imixs-office-archetype is a maven archetype to generate a custom build of Imixs-Office-Workflow. 


## Prerequisites
_Imixs-Office-Workflow_ is a Java Enterprise Application. 
You  don't have to be a Java EE developer, however, it is useful to be familiar with the concepts of Java and Java EE. 
_Imixs-Office-Workflow_ itself is running on an application server. With the help of Docker a manual installation of a Java EE application server is not required. If you go through this tutorial, the application will be deployed into a docker container. This Docker image can also be used in production environment, though, a custom configuration is recommended for most cases. 


### Checkout Sources
Although it is not absolutely necessary, it simplifies the development of a custom build, when you can have a look at the source code of _Imixs-Office-Workflow_. For this reason, we recommend the sources of which are available on [GitHub](https://github.com/imixs/imixs-office-workflow) to import in a suitable development environment. 


### Maven 3.x
_Imixs-Office-Workflow_ can be build with maven. It is recommended that you have installed [Apache Maven 3.0](https://maven.apache.org/) or higher. Also you should be familiar with the build concept of maven. 

## Let's get Started!
When you met the prerequisites, then you can start with your custom build. As _Imixs-Office-Workflow_ is based on Maven even the custom build is created by a Maven Archetype. 
 You can change the behavior and layout of your custom build without conflicting with any updates made by the _Imixs-Office-Workflow_  project. Also you can easily upgrade to any new version.



### Creating a custom build using Eclipse

To create a new maven project from an archetype you can use the Eclipse IDE with the Maven Plugin (m2e). This Eclipse plugin provides an easy wizard to create a new maven project based on an archetype.

1. From the main menue choose 'File -> New -> other'
2. Select 'Maven -> Maven Project' and click next
3. Leave the default creation setup and click next again
4. Now search for the Imixs archetype by entering 'org.imixs.workflow'. Eclipse will search the repository for the latest archetype
5. Click next to setup your project, choose a groupID and artifactID
6. Click finish to create the project

![](http://www.imixs.org/marty/images/maven001a.png)

It is also possible to create a custom build using maven command line tool: 

    mvn archetype:generate -Dfilter=imixs-office

## Run with Docker

Imixs-Office-Workflow provides a Docker Container to run the service on any Docker host. The docker image is based on the docker image imixs/wildfly.

Docker for Development

Developers can use a docker image for testing and the development of new features. To build a new container first build the maven artefact running:

    mvn clean install -Pdocker

To start Imixs-Office-Workflow with docker the docker-compose command can be used:

    docker-compose up

**Note:** this command will start two containers, a postgreSQL server and a Wildfly Server. See the docker-compose.yml file for the configuration details.

## Mount Points

The default configuration sets a local mount point at the following location:

    ~/git/imixs-office-workflow/src/docker/.deployments

Make sure that this directory exits. During development new versions can easily deployed into this directory which is the auto-deployment folder of Wildfly. For further details see the imixs/wildfly docker image.

## Docker for Production

To run Imixs-Office-Workflow in a Docker production environment the project proveds serveral additional maven profiles:

### docker-build

With the profile 'docker-build' a docker container based on the current version of Imixs-Office-Workflow is created locally

    mvn clean install -Pdocker-build

### docker-push

With the 'docker-push' profile the current version of Imixs-Office-Workflow can be pushed to a remote repository:

    mvn clean install -Pdocker-push -Dorg.imixs.docker.registry=localhost:5000

where 'localhost:5000' need to be replaced with the host of a private registry. See the docker-push command for more details.

### docker-hub

Imixs-Office-Workflow is also available on Docker-Hub. The public docker images can be used for development and production. If you need technical support please contact imixs.com


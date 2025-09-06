# Imixs-Office-Archetype

[Imixs-Office-Workflow](http://www.office-workflow.de) is a powerful and highly customizable workflow application platform.
Although Imixs-Office-Workflow can be used out of the box as a standard application, it is also possible to create a so-called
custom build. A custom build inherits all the functionality of the Imixs-Office-Workflow but also provides the ability to add or customize new features.

The imixs-office-archetype is a maven archetype to generate a custom build of Imixs-Office-Workflow.

## Prerequisites

_Imixs-Office-Workflow_ is a Java Enterprise Application.
You don't have to be a Java EE developer, however, it is useful to be familiar with the concepts of Java and Java EE.
_Imixs-Office-Workflow_ itself is running on an application server. With the help of Docker a manual installation of a Java EE application server is not required. If you go through this tutorial, the application will be deployed into a docker container. This Docker image can also be used in production environment, though, a custom configuration is recommended for most cases.

### Maven 3.x & Docker

_Imixs-Office-Workflow_ can be build with maven. It is recommended that you have installed [Apache Maven 3.0](https://maven.apache.org/) or higher. Also you should be familiar with the build concept of maven.
To run you application we use Docker. Make sure you have installed the Docker runtime before you start.

## Let's get Started!

When you met the prerequisites, then you can start with your custom build. As _Imixs-Office-Workflow_ is based on Maven even the custom build is created by a Maven Archetype.

You can change the behavior and layout of your custom build without conflicting with any updates made by the _Imixs-Office-Workflow_ project. Also you can easily upgrade to any new version.

### Creating a custom build using Eclipse

To create a new maven project from an archetype you can use the maven commandline tool:

```bash
$ mvn archetype:generate\
    -DarchetypeGroupId=org.imixs.workflow\
    -DarchetypeArtifactId=imixs-office-archetype\
    -DarchetypeVersion=5.1.0
```

The result will be created in a directory structure like this:

```
my-office-app/
├── devi
├── pom.xml
├── src/
│   └── main/
│       ├── java/
│       │   └── (optional new java classes)
│       └── webapp/
│           ├── WEB-INF/
│           │   └── (optional new configuration settings)
│           └── (new pages)
└── target/
```

The directory contains a bash script to build and start the environment. Change the execution flag if necessary (Linux)

```bash
$ chmod u+x devi
```

You can setup the environment with:

```bash
$ ./devi setup
```

To start the docker environment run:

```bash
$ ./devi start
```

To build the application run:

```bash
$ ./devi build
```

## Mount Points

The default configuration sets a local mount point for a hot deployment and the import of data files:

```xml
....
    volumes:
      - ./docker/deployments:/opt/jboss/wildfly/standalone/deployments/
      - ./import_examples:/opt/jboss/import_examples/
...
```

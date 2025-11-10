# Imixs-Office-Archetype

[Imixs-Office-Workflow](http://www.office-workflow.de) is a powerful and highly customizable workflow application platform.
Although Imixs-Office-Workflow can be used out of the box as a standard application, it is also possible to create a so-called
**custom build**. A custom build inherits all the functionality of the Imixs-Office-Workflow but also provides the ability to add or customize new features.

The project imixs-office-archetype provides a maven archetype to generate such kind of custom builds based of [Imixs-Office-Workflow](http://www.office-workflow.de).

## Prerequisites

**Imixs-Office-Workflow** is a Java Enterprise Application based on the [Jakarta EE platform](https://jakarta.ee/).
You don't have to be a Java EE developer, however, it is useful to be familiar with the concepts of Java and Java EE.
**Imixs-Office-Workflow** itself is running on an application server. With the help of Docker a manual installation of a Java EE application server is not required. If you go through this tutorial, the application will be deployed into a docker container. This Docker image can also be used in production environment, though, a custom configuration is recommended for most cases.

### Maven & Docker

**Imixs-Office-Workflow** can be build with maven. It is recommended that you have installed [Apache Maven 3.0](https://maven.apache.org/) or higher. Also you should be familiar with the build concept of maven. To run you application we use Docker. Make sure you have installed the Docker runtime before you start.

## Let's get Started!

When you met the prerequisites, then you can start with your custom build. As **Imixs-Office-Workflow** is based on Maven even the custom build is created by a Maven Archetype. You can change the behavior and layout of your custom build without conflicting with any updates made by the Imixs-Office-Workflow project. Also you can easily upgrade to any new version. Find details about the maven build concept below.

### Creating a custom build using Eclipse

To create a new maven project from an archetype you can use the maven commandline tool:

```bash
$ mvn archetype:generate\
    -DarchetypeGroupId=org.imixs.workflow\
    -DarchetypeArtifactId=imixs-office-archetype\
    -DarchetypeVersion=5.1.2
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

### Mount Points

The default configuration sets a local mount point for a hot deployment and the import of data files:

```xml
....
    volumes:
      - ./docker/deployments:/opt/jboss/wildfly/standalone/deployments/
      - ./import_examples:/opt/jboss/import_examples/
...
```

## Maven Dependencies

A custom build of **Imixs-Office-Workflow** is based on a so called 'WAR overlay'. This is a powerful maven concept to build web applications on an existing one. In order to build a WAR overlay, the WAR of the base project is included as a dependency to the custom build and must be _overlayed_ during the war-plugin package phase.
Files are placed in their parent's locations if it exists. What this means is that if, in the overlay WAR an artefact file `layout/template.xthml` exists, the custom build will then also have this file. Furthermore, if there is already a file named `layout/template.xthml` in the custom build, that file will not be overwritten.
**Note:** Also the libraries in the `/WEB-INF/lib` folder from the overlay will be placed inside the `/WEB-INF/lib` folder of the custom build. This is great and all except when different versions of libraries exist causing runtime failures. So you need care to manage the dependencies in your custom build. You can find a good overview about the concept [here](`layout/template.xthml`).

### Exclude dependencies/libraries

It can be a pain to manage the dependencies between each of the overlays, especially if the overlay is not under your development control.
As **Imixs-Office-Workflow** also stands as stand-alone project, it is not possible to manage the dependencies within the two POM files by utilizing the "provided" and "optional" dependencies. The solution to control the overlay libraries is to exclude them from the WAR during the package phase. This is achieved by using the "excludes" parameter in each of the overlay sections.

```xml
...
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>3.3.1</version>
        <configuration>
            <failOnMissingWebXml>false</failOnMissingWebXml>
            <webResources>
                <resource>
                    <filtering>true</filtering>
                    <!-- this is relative to the pom.xml directory -->
                    <directory>${custom.webResources}</directory>
                    <includes>
                        <include>**/WEB-INF/*</include>
                        <!-- include any other file types you want to filter -->
                    </includes>
                </resource>
            </webResources>
            <overlays>
                <!-- Exclude libs from overlay project -->
                <overlay>
                    <groupId>org.imixs.workflow</groupId>
                    <artifactId>imixs-office-workflow-app</artifactId>
                    <excludes>
                        <exclude>WEB-INF/lib/*.jar</exclude>
                    </excludes>
                </overlay>
            </overlays>
        </configuration>
    </plugin>
...
```

This means no libraries from the Imixs-Office-Workflow overlay project will be added by default into the `/WEB-INF/lib/` folder. For this reason you need to add the needed maven dependencies like in the master project onto your `pom.xml`. The Imixs-Office-Archetype did exactly this and provides you with a pre configured setup of the pom.xml file in your custom build. You can easily change the versions in the `properties` section of your `pom.xml` file and add custom dependencies into the `dependencies` section. This gives you the full control how to build your own project.

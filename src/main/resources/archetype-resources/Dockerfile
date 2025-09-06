FROM imixs/imixs-office-workflow:5.1.3-SNAPSHOT-wildfly-29.0.1.Final-jdk17

# Deploy artefact
RUN rm -r /opt/jboss/wildfly/standalone/deployments/*
# Deploy artefact
ADD ./*.war /opt/jboss/wildfly/standalone/deployments/


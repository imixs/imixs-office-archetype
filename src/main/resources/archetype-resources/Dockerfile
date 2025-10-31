FROM imixs/imixs-office-workflow:5.1.5-wildfly-29.0.1.Final-jdk17

# Deploy artefact
RUN rm -r /opt/jboss/wildfly/standalone/deployments/*
# Deploy artefact
COPY ./target/*.war /opt/jboss/wildfly/standalone/deployments/


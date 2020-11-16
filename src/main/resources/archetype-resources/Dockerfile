FROM imixs/imixs-office-workflow:4.3.1

# Deploy artefact
RUN rm -r /opt/jboss/wildfly/standalone/deployments/*
COPY ./*-app/target/*.war /opt/jboss/wildfly/standalone/deployments/

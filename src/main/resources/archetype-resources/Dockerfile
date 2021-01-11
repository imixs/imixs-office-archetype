FROM imixs/imixs-office-workflow:4.4.0

# Deploy artefact
RUN rm -r /opt/jboss/wildfly/standalone/deployments/*
COPY ./*-app/target/*.war /opt/jboss/wildfly/standalone/deployments/

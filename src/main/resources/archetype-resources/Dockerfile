FROM imixs/wildfly:1.2.5

# Setup configuration
COPY ./src/docker/configuration/imixsrealm.properties ${WILDFLY_CONFIG}/
COPY ./src/docker/configuration/standalone.xml ${WILDFLY_CONFIG}/

# Deploy artefact
COPY ./*-ear/target/*-ear-*.ear ${WILDFLY_DEPLOYMENT}/

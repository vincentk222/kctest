# A example build step that downloads a JAR file from a URL and adds it to the providers directory
FROM quay.io/keycloak/keycloak:latest AS builder

# Add the provider JAR file to the providers directory
ADD --chown=keycloak:keycloak --chmod=644 ./target/keycloak-restricted-access-authenticator.jar /opt/keycloak/providers/myprovider.jar

COPY ck-theme /opt/keycloak/themes/ck-theme

# Context: RUN the build command
RUN /opt/keycloak/bin/kc.sh build
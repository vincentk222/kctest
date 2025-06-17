package com.cklu.auth;

import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.AuthenticationExecutionModel;
import org.keycloak.provider.ProviderConfigProperty;

import java.util.List;

public class RestrictedAccessAuthenticatorFactory implements AuthenticatorFactory {
    public static final String ID = "restricted-access-authenticator";

    @Override
    public String getId() {
        return ID;
    }

    @Override
    public String getDisplayType() {
        return "Restricted Access Evaluator";
    }

    @Override
    public String getHelpText() {
        return "Denies access for users with 'restricted-access' attribute or role.";
    }

    @Override
    public Authenticator create(KeycloakSession session) {
        return new RestrictedAccessAuthenticator();
    }

    @Override
    public void init(org.keycloak.Config.Scope config) {}

    @Override
    public void postInit(org.keycloak.models.KeycloakSessionFactory factory) {}

    @Override
    public void close() {}

    @Override
    public boolean isConfigurable() {
        return false;
    }

    @Override
    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return new AuthenticationExecutionModel.Requirement[]{
                AuthenticationExecutionModel.Requirement.REQUIRED
        };
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        // Return an empty list since no configuration is required
        return List.of();
    }

    @Override
    public String getReferenceCategory() {
        // Return null or a category string as appropriate for your use case
        return null;
    }

    @Override
    public boolean isUserSetupAllowed() {
        // Return false if user setup is not allowed
        return false;
    }
}


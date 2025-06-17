package com.cklu.auth;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticationFlowError;
import org.keycloak.models.*;
import org.keycloak.organization.OrganizationModel;
import org.keycloak.organization.OrganizationProvider;
import jakarta.ws.rs.core.Response;

import java.util.Optional;

public class RestrictedAccessAuthenticator implements Authenticator {

    private static final String ACCESS_ROLE_NAME = "access";
    private static final String REDIRECT_URI_PREFIX = "redirect_uri_";

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        ClientModel client = context.getAuthenticationSession().getClient();

        if (user == null) {
            context.success();
            return;
        }

        // --- Check access rights via composite role ---
        RoleModel accessRole = client.getRole(ACCESS_ROLE_NAME);
        if (accessRole != null) {
            boolean hasMatchingRole = accessRole.getCompositesStream()
                    .anyMatch(user::hasRole);

            if (!hasMatchingRole) {
                context.failure(AuthenticationFlowError.ACCESS_DENIED,
                        context.form().setError("accessDenied", "Your access is currently restricted").createErrorPage(Response.Status.FORBIDDEN));
                return;
            }
        }

        // --- Dynamic redirect based on organization attribute ---
        KeycloakSession session = context.getSession();
        OrganizationProvider orgProvider = session.getProvider(OrganizationProvider.class);
        Optional<OrganizationModel> userOrg = orgProvider.getUserOrganization(user);

        if (userOrg.isPresent()) {
            String clientId = client.getClientId();
            String dynamicAttrName = REDIRECT_URI_PREFIX + clientId;
            String orgRedirectUri = userOrg.get().getAttribute(dynamicAttrName);

            if (orgRedirectUri != null && !orgRedirectUri.isBlank()) {
                context.getAuthenticationSession().setRedirectUri(orgRedirectUri);
            }
        }

        context.success();
    }

    @Override
    public void action(AuthenticationFlowContext context) {
        // No action required
    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
        // No required actions
    }

    @Override
    public void close() {
        // Nothing to close
    }
}
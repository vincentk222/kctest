<#-- login.ftl - Custom Keycloak login page -->
<#assign backgrounds = ["bg1.png", "bg2.png", "bg3.png"]>
<#assign randomIndex = (.now?long % backgrounds?size)?int>
<#assign selectedBg = backgrounds[randomIndex]>

<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${kcSanitize(msg("loginPageTitle"))?no_esc}</title>
  <link rel="stylesheet" href="${url.resourcesPath}/css/styles.css">
  <style>
    .image-section {
      background-image: url('${url.resourcesPath}/images/${selectedBg}');
    }
  </style>
</head>
<body>
  <div class="container">
    <button class="theme-icon" onclick="toggleTheme()" title="Changer de thème">🌓</button>

    <div class="login-section">
      <div class="login-box">
        <h1>${kcSanitize(msg("welcomeGreeting"))?no_esc}</h1>
        <p>${kcSanitize(msg("loginInstruction"))?no_esc}</p>

        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
          <#if message?has_content>
            <div class="alert ${message.type}">
              ${message.summary}
            </div>
          </#if>

          <div class="form-group">
            <label for="username">${kcSanitize(msg("emailLabel"))?no_esc}</label>
            <input type="text" id="username" name="username" value="${login.username!''}" placeholder="${kcSanitize(msg('emailPlaceholder'))?no_esc}" required autofocus>
          </div>

          <div class="form-group">
            <label for="password">${kcSanitize(msg("passwordLabel"))?no_esc}</label>
            <input type="password" id="password" name="password" placeholder="${kcSanitize(msg('passwordPlaceholder'))?no_esc}" required>
          </div>

          <div class="form-extra">
            <label>
              <input type="checkbox" id="rememberMe" name="rememberMe" <#if login.rememberMe?? && login.rememberMe == 'on'>checked</#if>>
              ${kcSanitize(msg("rememberMeLabel"))?no_esc}
            </label>
            <#if realm.resetPasswordAllowed>
              <a href="${url.loginResetCredentialsUrl}">${kcSanitize(msg("forgottenPasswordLink"))?no_esc}</a>
            </#if>
          </div>

          <button type="submit" name="login">${kcSanitize(msg("loginButton"))?no_esc}</button>
        </form>

        <#if realm.registrationAllowed>
          <p style="margin-top:20px;">
            ${kcSanitize(msg("createAccountMessage"))?no_esc}
            <a href="${url.registrationUrl}">${kcSanitize(msg("createAccountLink"))?no_esc}</a>
          </p>
        </#if>
      </div>
    </div>

    <div class="image-section"></div>
  </div>

  <script>
    function toggleTheme() {
      document.body.classList.toggle('dark-mode');
    }

    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
      document.body.classList.add('dark-mode');
    }
  </script>
</body>
</html>

<#-- reset-credentials.ftl - Custom Keycloak reset credentials page -->
<#assign backgrounds = ["bg1.png", "bg2.png", "bg3.png"]>
<#assign randomIndex = (.now?long % backgrounds?size)?int>
<#assign selectedBg = backgrounds[randomIndex]>

<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${kcSanitize(msg("resetCredentialsTitle"))?no_esc}</title>
  <link rel="stylesheet" href="${url.resourcesPath}/css/styles.css">
  <link rel="stylesheet" href="${url.resourcesPath}/css/reset.css">
  <style>
    .image-section {
      background-image: url('${url.resourcesPath}/images/${selectedBg}');
    }
  </style>
</head>
<body>
  <div class="container">
    <button class="theme-icon" onclick="toggleTheme()" title="Changer de thème">🌓</button>

    <div class="reset-section">
      <div class="reset-box">
        <h1>${kcSanitize(msg("resetCredentialsGreeting"))?no_esc}</h1>
        <p>${kcSanitize(msg("resetCredentialsInstruction"))?no_esc}</p>

        <form id="kc-reset-credentials-form" action="${url.loginAction}" method="post">
          <#if message?has_content>
            <div class="alert ${message.type}">
              ${message.summary}
            </div>
          </#if>

          <div class="form-group">
            <label for="username">${kcSanitize(msg("emailLabel"))?no_esc}</label>
            <input type="text" id="username" name="username" value="${login.username!''}" placeholder="${kcSanitize(msg('emailPlaceholder'))?no_esc}" required autofocus>
          </div>

          <button type="submit">${kcSanitize(msg("resetButton"))?no_esc}</button>
        </form>

        <p style="margin-top:20px;">
          <a href="${url.loginUrl}">${kcSanitize(msg("backToLoginLink"))?no_esc}</a>
        </p>
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

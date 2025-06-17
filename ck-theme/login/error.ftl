<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${kcSanitize(msg("errorTitle"))?no_esc}</title>
  <link rel="stylesheet" href="${url.resourcesPath}/css/styles.css">
</head>
<body>
  <div class="error-container">
    <div class="error-box">
      <h1>${kcSanitize(msg("errorTitle"))?no_esc}</h1>
      <p>${kcSanitize(message.summary)?no_esc}</p>
      <#if skipLink??>
      <#else>
        <#if client?? && client.baseUrl?has_content>
          <a id="backToApplication" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a>
        </#if>
      </#if>
    </div>
  </div>
</body>
</html>
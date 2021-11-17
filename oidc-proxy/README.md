# OIDC Proxy

This exists to workaround some issues with OIDC providers that do not support `?` in the callback URL. As matomo plugins require that the plugin is mentioned in the query string.

It does this by providing a proxy that will proxy and rewrite `/_oauth/callback?*` to `/index.php?module=LoginOIDC&action=callback&provider=oidc<*>`. This provides you with a callback url that does not contain a `?`.
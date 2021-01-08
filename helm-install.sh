#!/bin/sh

helm upgrade \
    --install \
    --namespace my-app \
    --create-namespace \
    --set OAUTH2_PROXY_CLIENT_ID=$OAUTH2_PROXY_CLIENT_ID \
    --set OAUTH2_PROXY_CLIENT_SECRET=$OAUTH2_PROXY_CLIENT_SECRET \
    --set OAUTH2_PROXY_COOKIE_SECRET=$OAUTH2_PROXY_COOKIE_SECRET \
    --set url=my-app.example.com
    --set ingressSecretName=tls-secret
    my-app \
    .

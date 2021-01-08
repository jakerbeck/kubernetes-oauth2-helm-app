#!/bin/sh

APP="my-app"

if ! kubectl get namespaces | grep "$APP"; then
    kubectl create namespace $APP
fi

helm upgrade \
    --install \
    --namespace $APP \
    --set OAUTH2_PROXY_CLIENT_ID=$OAUTH2_PROXY_CLIENT_ID \
    --set OAUTH2_PROXY_CLIENT_SECRET=$OAUTH2_PROXY_CLIENT_SECRET \
    --set OAUTH2_PROXY_COOKIE_SECRET=$OAUTH2_PROXY_COOKIE_SECRET \
    --set url=my-app.example.com
    --set ingressSecretName=tls-secret
    $APP \
    .

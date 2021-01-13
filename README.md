# kubernetes-oauth2-helm-app
A Helm Chart example of an appliction that is secured using Github.  Based on the oauth2-proxy project.


## Grossly Oversimplified Architecture
```
[ Client ] ► [ Ingress ] ► [ OAuth2 Proxy ] ► [ Protected App ] 
    ▼ ▲                        ▼ ▲
  [    OAuth2 Provider (Github)    ]
```

## Quick Start
#### Clone the Repository
```shell
git clone https://github.com/jakerbeck/kubernetes-oauth2-helm-app.git
cd kubernetes-oauth2-helm-app
```

#### Set Environment Variables (or less securely use `values.yaml`)
```shell
APP_NAME="my-application"
URL=my-app.example.com
INGRESS_SECRET_NAME="tls-secret"
OAUTH2_PROXY_CLIENT_ID="12345678910111213141"
OAUTH2_PROXY_CLIENT_SECRET="2345678910111213141516171819202122232425"
OAUTH2_PROXY_COOKIE_SECRET=$(openssl rand -hex 16)
```

#### Deploy with Helm
```shell
helm upgrade \
    --install \
    --namespace ${APP_NAME} \
    --create-namespace \
    --set OAUTH2_PROXY_CLIENT_ID=${OAUTH2_PROXY_CLIENT_ID} \
    --set OAUTH2_PROXY_CLIENT_SECRET=${OAUTH2_PROXY_CLIENT_SECRET} \
    --set OAUTH2_PROXY_COOKIE_SECRET=${OAUTH2_PROXY_COOKIE_SECRET} \
    --set URL=${URL} \
    --set INGRESS_SECRET_NAME=${INGRESS_SECRET_NAME} \
    -f ./values.yaml \
    ${APP_NAME} \
    .
```

#### TLS
Update the `...` with your certificate and key data:
```shell
echo "\
---
apiVersion: v1
kind: Secret
metadata:
  name: ${INGRESS_SECRET_NAME}
  namespace: ${APP_NAME}
type: Opaque
stringData:
  tls.key: |-
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
  tls.crt: |-
-----BEGIN PRIVATE KEY-----
...
-----END PRIVATE KEY-----\
" | kubectl apply -f -
```

## Email Authentication
Set a list of emails in values.yaml

## Special Thanks
https://github.com/oauth2-proxy/oauth2-proxy

https://kubernetes.github.io/ingress-nginx/examples/auth/oauth-external-auth/

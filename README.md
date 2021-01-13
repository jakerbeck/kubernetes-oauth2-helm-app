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
```
git clone https://github.com/jakerbeck/kubernetes-oauth2-helm-app.git
cd kubernetes-oauth2-helm-app
```

#### Set Environment Variables (or less securely use `values.yaml`)
```
APP_NAME="my-application"
URL=my-app.example.com
INGRESS_SECRET_NAME="tls-secret"
OAUTH2_PROXY_CLIENT_ID="12345678910111213141"
OAUTH2_PROXY_CLIENT_SECRET="2345678910111213141516171819202122232425"
OAUTH2_PROXY_COOKIE_SECRET=$(openssl rand -hex 16)
```

#### Deploy with Helm
```
helm upgrade \
    --install \
    --namespace ${APP_NAME} \
    --create-namespace \
    ${SET_OAUTH2_PROXY_CLIENT_ID} \
    ${SET_OAUTH2_PROXY_CLIENT_SECRET} \
    ${SET_OAUTH2_PROXY_COOKIE_SECRET} \
    ${SET_URL} \
    ${SET_INGRESS_SECRET_NAME} \
    ${APP_NAME} \
    .
```

#### TLS
Update the `...` with your certificate and key data:
```
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

## Special Thanks
https://github.com/oauth2-proxy/oauth2-proxy

https://kubernetes.github.io/ingress-nginx/examples/auth/oauth-external-auth/

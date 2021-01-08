# kubernetes-oauth2-helm-app
A simple application Helm Chart example of an appliction that is secured using Github.

# Usage
Clone the repository (or make your own)
```
git clone git@github.com:jakerbeck/kubernetes-oauth2-helm-app.git
cd kubernetes-oauth2-helm-app
```

Set Environment Variables (or less securely use `values.yaml`):
```
APP_NAME="my-application"
OAUTH2_PROXY_CLIENT_ID="12345678910111213141"
OAUTH2_PROXY_CLIENT_SECRET="2345678910111213141516171819202122232425"
OAUTH2_PROXY_COOKIE_SECRET=$(openssl rand -hex 16)
URL=my-app.example.com
INGRESS_SECRET_NAME="tls-secret"
```

Deploy with Helm:
```
./helm-install.sh
```

# Special thanks:
https://github.com/oauth2-proxy/oauth2-proxy

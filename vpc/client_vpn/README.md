+ https://docs.aws.amazon.com/ja_jp/vpn/latest/clientvpn-admin/mutual.html
+ log: https://gist.github.com/knknkn1162/8dfe678fa049c00c1650232e671a8015


+ client VPN installer: https://aws.amazon.com/jp/vpn/client-vpn-download/

```sh
cd assets
openssl x509 -in ${var.client_crt_filepath} -outform pem -out ${local.client_pem_filepath}
```
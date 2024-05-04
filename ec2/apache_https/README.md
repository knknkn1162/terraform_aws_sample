# prerequisites

1. create Route53 zone in your domain
2. create fullchain.pem and privkey.pem using certbot
  + dns challenge -> register txt record to verify
3. set ./ec2/assets/certs in the pem files
4. terraform apply
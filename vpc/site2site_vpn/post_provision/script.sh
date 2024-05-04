#!/bin/bash
rm -f priv.pem
terraform output -raw ssh_privkey > priv.pem
chmod 0400 priv.pem
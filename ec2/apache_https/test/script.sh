#!/bin/bash
domain=$1
for i in {1..200}
do
    nslookup "$domain" && break || sleep 5
done
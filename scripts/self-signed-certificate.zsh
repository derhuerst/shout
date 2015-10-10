#!/usr/bin/env zsh

openssl genrsa -des3 -out self-signed.pass.key 2048
openssl rsa -in self-signed.pass.key -out self-signed.key
openssl req -new -key self-signed.key -out self-signed.csr
openssl x509 -req -days 365 -in self-signed.csr -signkey self-signed.key -out self-signed.crt

echo "SHA1 fingerprint:\n"
openssl x509 -in self-signed.crt -sha1 -noout -fingerprint

rm self-signed.pass.key
rm self-signed.csr

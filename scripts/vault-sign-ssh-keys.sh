#!/bin/bash
# Sign all available keys into ~/.ssh/*-cert.pub files.
# Shaun Meyer, Feb 2023
#
set -o allexport; source ~/.env; set +o allexport

# Check Vault login; resolves an issue where I had an expired
# VAULT_TOKEN env variable. This will check the on-disk (when VAULT_TOKEN) 
# is empty but also check the variable if it is not empty.
# 
# The script will still fail, but you have a prayer because one of the error
# messages is "The VAULT_TOKEN environmental variable is set!"
#
if ! [ -e ~/.vault-token ] || ! vault token lookup "${VAULT_TOKEN}"; then
    echo "Vault doesn't appear to be logged in, assuming username=${USER}..."
    vault login -address=https://vault.morningside.edu:8200 -method=ldap username="${USER}"
fi

for public_key in $HOME/.ssh/id*.pub; do
    if [[ ${public_key} == *"-cert.pub" ]]; then 
        continue; 
    fi
    identity=$(basename --suffix=.pub "${public_key}")
    identity_path=$(dirname "${public_key}")/${identity}
    cert_path=${identity_path}-cert.pub

    echo Signing $public_key
    
    vault write -field=signed_key \
        ssh-user-ca/sign/root \
        public_key=@$public_key \
        valid_principals=root > ${cert_path}
done

exit


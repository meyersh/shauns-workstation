#!/bin/bash
set -o allexport; source ~/.env; set +o allexport

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


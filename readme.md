# Shauns-Workstation

I've been building up some useful and portable tooling for common work tasks, 
resulting in this repository of generally sanitary (no secrets) contents.

## Table of contents

```
.                                    #
├── readme.md                        # This file
└── scripts                          # The scripts!
    ├── govc                         # A dockerized version of the govc vmware cli util
    ├── vault-sign-ssh-keys.sh       # A wrapper to maintain a signed ssh certificate
    └── vconsole                     # A wrapper to lookup and open remote vmware consoles
```



## Configuration

### `.govc-env` - VMWare Credentials

To connect, `govc` requires a `~/.govc-env` file containing something like the following:

```
GOVC_URL=vcenter67.morningside.edu
GOVC_USERNAME=administrator@vsphere.local
GOVC_PASSWORD=the-password'
GOVC_INSECURE=true
```

### Vault stuff

Vault always assumes `$VAULT_ADDR` is populated (but it never is,) so
`~/.env` can contain something like

```
VAULT_ADDR=https://vault.morningside.edu:8200
```
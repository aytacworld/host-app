# Host-app

Host-app is a server application (like Heroku or Dokku), but simplified for only one user and under your own domain.

You need to run the script on a freshly installed VPS, it will configure your hostname, hosts, add a sudo user, add the nessecary scripts.

# Current State
The scripts will work only on Arch Linux, but in the future I will try to add
scripts for other Distros and OS.

It works as a simple server, but if you find some security issues, please contact me about it, or create a fork and make a pull request with the fix.

Only Node projects are supported. You can create a pull request for other type of projects as well.

# Prerequisites
- Create wildcard record in your DNS zone
  ```bash
  *  CNAME  app.@
  ```
  _@ point to your domain (eg. example.com)_

# Setup
After installing a fresh Arch Linux, run the following as a root user.

```bash
cd ~
git clone https://github.com/aytacworld/host-app
cd host-app
chmod +x ./setup
./setup
```

# Update host-app

`ha update`

# Add new application
To add a new project, run this command.

`ha new <app-name>`

# Troubleshooting
pacman -S ca-certificates ca-certificates-utils ca-certificates-cacert ca-certificates-mozilla
## If you get the following error
```bash
Cloning into 'host-app'...
fatal: unable to access 'https://github.com/aytacworld/host-app/': error setting certificate verify locations:
  CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: none
```
Install the ca-certificate packages, and retry to clone the project.

```bash
pacman -S ca-certificates ca-certificates-utils ca-certificates-cacert ca-certificates-mozilla
```
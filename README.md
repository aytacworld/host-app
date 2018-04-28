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
pacman -S ca-certificates ca-certificates-utils ca-certificates-cacert ca-certificates-mozilla
cd ~
git clone https://github.com/aytacworld/host-app
cd host-app
chmod +x ./setup
./setup
```

After the setup, you should be able to navigate to your FQDN(eg. app.example.com) from any browser.

# Usage

- ha new <app-name>
- ha update <app-name>
- ha delete <app-name>
- ha list
- ha update-host

# TODO

- replace npm by yarn
- package.json engines (run an app with specific version of node, npm, yarn, ...)
- add bash-completion

# Troubleshooting

## If the setup stops at certain step, you can continue from that step running the setup script like this
```bash
./setup <step-number>
```

## If you get this error
```bash
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 10453: ordinal not in range(128)
```
try to find a unicode character, which is failing the script, by doing:
```bash
sudo grep -r -P '[^\x00-\x7f]' /etc/nginx /etc/letsencrypt
```
If it returns some outputs, open the files, and remove those characters. And rerun the setup script from where you left(`./setup 3`)

## Npm command not found
```bash
/home/user/host-app/scripts/4/script.sh: line 17: npm: command not found
```
type `exit`, so you will be on root account, then relogin as user `su -l <USERNAME>`, and rerun the setup script `cd host-app && ./setup 4`
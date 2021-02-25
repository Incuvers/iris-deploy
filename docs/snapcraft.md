# Snapcraft Login Token
Modified: 2021-02

A snapcraft login token is essential for continous deployment pipelines to be able to automatically push new snaps to the snap store. This token is shared to deployment servers through the github action runners by linking the token to the source repositories secrets.

## Token Parameters
The snapcraft login token stored in Incuvers/monitor as `SNAP_TOKEN` is generated with the following parameters:
 - Modification priveleges restricted to the `iris-incuvers` snap
 - Grants the following permissions on the `edge` channel: ['package_access', 'package_manage', 'package_push', 'package_register', 'package_release', 'package_update']
 - Token expires on `2022-02-25T18:15:07.476655`

## Generating tokens
You will be required to sign in to the user `info@incuvers.com` to generate a token:
```bash
snapcraft export-login --snaps iris-incuvers --channels edge -
```
Go to the Incuvers/monitor repository under > Settings > Secrets > SNAP_TOKEN > Update and paste the token into the text box. Because this token will expire in a year, in the future we could sequentially generate new snapcraft tokens when a token is expired and use the github api to automatically register new tokens.
# Iris Deployment Server
[![shellcheck](https://github.com/Incuvers/iris-deploy/actions/workflows/shellcheck.yaml/badge.svg?branch=master)](https://github.com/Incuvers/iris-deploy/actions/workflows/shellcheck.yaml) [![yamllint](https://github.com/Incuvers/iris-deploy/actions/workflows/yamllint.yaml/badge.svg?branch=master)](https://github.com/Incuvers/iris-deploy/actions/workflows/yamllint.yaml)

![img](/docs/img/Incuvers-black.png)

Modified: 2021-02

## Action Usage
```yaml
...
snap-deploy:
name: iris snap deployment
runs-on: [self-hosted, linux, ARM64]
steps:
  - name: Deploy iris snap to edge
    uses: Incuvers/iris-deploy@master
    with:
        SNAP_TOKEN: ${{ secrets.SNAP_TOKEN }}
        SLACK_IDENTIFIER: ${{ secrets.SLACK_NOTIFICATIONS }}
        ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        ACCESS_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
...
```

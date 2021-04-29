# Iris Deployment Server
[![shellcheck](https://github.com/Incuvers/iris-deploy/actions/workflows/shellcheck.yaml/badge.svg?branch=master)](https://github.com/Incuvers/iris-deploy/actions/workflows/shellcheck.yaml) [![yamllint](https://github.com/Incuvers/iris-deploy/actions/workflows/yamllint.yaml/badge.svg?branch=master)](https://github.com/Incuvers/iris-deploy/actions/workflows/yamllint.yaml)

![img](/docs/img/Incuvers-black.png)

Modified: 2021-03

## Action Runner Brief
The code in this repository is executed as defined by the [action.yaml](action.yaml) file in the root of this repository. This action can be invoked in another repositories build-spec by pointing to this action (see [Action Usage](#action-usage)). This action is not deployed to a server directly and instead is pulled by the github action runner when the build-spec requires this action. This way subsequent updates to this deploy action on the target branch will be automatically be pulled by the deployment server so it is always running the latest source code.

## Iris Deploy Server Deployment
To deploy the iris deploy server visit [Incuvers/automation](https://github.com/Incuvers/automation) and follow the setup instructions.

## Action Usage
Sample workflow job:
```yaml
...
snap-deploy:
name: iris snap deployment
runs-on: [self-hosted, linux, x64]
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

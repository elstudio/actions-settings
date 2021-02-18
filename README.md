# actions-settings
GitHub Action to run [Probot settings](https://github.com/probot/settings) to set repository defaults.

This action simply runs probot-settings, which can be used to set up labels, branch protection rules -- pretty much anything on the repository settings tab. Settings are read from a yaml file in the repository.


## Example Use

Example `probot-settings.yml` file:

```yaml
name: Enforce repository settings

on: [push]

jobs:
  probot-settings:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-node@v2
      with:
        node-version: '12'
    - name: Run probot-settings
      uses: elstudio/actions-settings@v3-beta
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Permissions

Actions-settings runs the probot/settings app, and it requires permissions sufficient to do whatever you specify in `settings.yml`. Updating labels, for example, can be done with the default permissions that `secrets.GITHUB_TOKEN` provides.

Chaning other settings require more powers, though. Branch protections, for example, require admin-level permissions.

While you could use a PAT with elevated permissions for this, it's generally better to use a GitHub App to generate a temporary token with just the necessary permissions. See [peter-murray/workflow-application-token-action](https://github.com/peter-murray/workflow-application-token-action) for an action that makes this easy.

Here's an example of a workflow that uses an application token to authenticate:

```yaml
name: Enforce repository settings using an app token

on: 
  push:

jobs:
  settings:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-node@v2
      with:
        node-version: '12'
    - name: Get Token
      id: get_workflow_token
      uses: peter-murray/workflow-application-token-action@v1
      with:
        application_id: ${{ secrets.TOKEN_APP_ID }}
        application_private_key: ${{ secrets.TOKEN_APP_PRIVATE_KEY }}
    - name: Run probot-settings
      uses: elstudio/actions-settings@v3-beta
      env:
        GITHUB_TOKEN: ${{ steps.get_workflow_token.outputs.token }}
```


### A fancer example

Let's say you run `probot-settings` just one time. (Which is useful if you're setting up labels when a repository is first created.)

Fancier example `probot-settings.yml` file:

```yaml
name: Enforce repository settings just once

on: [push]

jobs:
  probot-settings:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-node@v2
      with:
        node-version: '12'
    - name: Run probot-settings
      uses: elstudio/actions-settings@v3-beta
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}


    - name: Remove workflow file from master branch
      run: rm ./.github/workflows/probot-settings.yml
      if: endsWith(github.ref, '/master') && ! endsWith(github.repository, '-template')

    - name: Commit changes
      uses: elstudio/actions-js-build/commit@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```


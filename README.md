# actions-settings
GitHub Action to run [Probot settings](https://github.com/probot/settings) to set repository defaults.

This action simply runs probot-settings, which can be used to set up labels, branch protection rules -- pretty much anything on the repository settings tab. Settings are read from a yaml file in the repository.


## Example Use

```
workflow "Repository settings" {
  on = "push"
  resolves = "Probot Settings"
}

action "Probot Settings" {
  uses = "elstudio/actions-settings@master"
  secrets = ["GITHUB_TOKEN"]
}
```

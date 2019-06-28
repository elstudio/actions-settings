# actions-settings
GitHub Actions to run Probot settings to set repository defaults.

This action simply runs https://github.com/probot/settings, which can be used to set up labels, branch protection rules -- pretty much anything on the repository settings tab.


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

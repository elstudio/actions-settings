# actions-settings
GitHub Actions to run Probot settings and set defaults

## Example Use

```
workflow "Set repository settings" {
  on = "push"
  resolves = "probot-settings"
}

action "probot-settings" {
  uses = "elstudio/actions-settings@master"
  secrets = ["GITHUB_TOKEN"]
}
```

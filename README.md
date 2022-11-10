# workspace-pattern

This is an example workspace with tailscale that minimizes complex logic in places where we don't want it (yaml, dockerfiles) or in places where it's not really meant for it (non build/release related takes as makefiles).


## Using tmux for systemd like effect (also launch tailscale as ephemeral):
```
tmux new-session -d -s tailscaled 'sudo /usr/sbin/tailscaled --state=mem:'
```

## dev/scripts
Populate [dev/scripts](dev/scripts) with things you want access in your environment, it is copied to `~/scripts` and added to your `PATH` in the Dockerfile.

## Dockerfile
Don't put all your install commands in the Dockerfile directly, besides being hard to troubleshoot / validate, almost all of it can be compressed to a single layer, put them in `prep_workspace`. If you have multiple / large layers, break out those install tasks to separate files. This would still allow for layer caching on builds, but keep your DockerFile legible.

Do expose ENV vars in the DockeFile that are  so it is easy to bump versions all in one place. The kubectl install in the current [dockerfile](dev/gitpod.DockerFile) uses that information, allowing you to 

Create a `build_workspace` command that duplicates the gitpod running's prebuild of your workspace easier.

## Tailscale

Don't store your state in your environment variable.

Do start tailscaled with `--state=mem:` ensuring the Tailscale servers will cleanup your workspace instance after it stops.


<br>

## Try it out

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/mrzarquon/workspace-pattern)

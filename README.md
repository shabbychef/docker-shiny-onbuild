# shiny-onbuild

A Dockerfile for shiny with `ONBUILD` directive. The `ONBUILD` directives
add any necessary packages, and copy the source directory to `/srv/shiny`.
The default commands run your app on port 5555. 


## Building

The 'onbuild-image' should be sourced from another Dockerfile and exists
to simplify deployment. You could build the onbuild image via

```
docker build --rm -t shabbychef/shiny-onbuild .
```

But probably better to just pull it from dockerhub:

```
docker pull shabbychef/shiny-onbuild
```

## Using

To use the onbuld-image, you should source `FROM` it. A minimal working
Dockerfile would look as follows:

```
FROM shabbychef/shiny-onbuild
MAINTAINER Your Name, name@email.com
```

You should create one of the files `apt_packages.txt`,
`r_packages.txt`, or `r_github_packages.txt`. In order, the `ONBUILD`
directives:

  1. Look for `apt_packages.txt`, which should contain one ubuntu package per line.
  Ignoring lines starting with a `#`, the packages are installed via `apt-get`.
  2. Look for `r_packages.txt`, which should contain one R package per line.
  Ignoring lines starting with a `#`, the packages are installed via little-r's
  `install.r` helper.
  3. Look for `r_github_packages.txt`, which should contain one fully qualified
  github-hosted R package per line.
  Ignoring lines starting with a `#`, the packages are installed via little-r's
  `installGithub.r` helper.

The `ONBUILD` directives then move the directory `/src` into place. The default
commands run shiny on port 5555, which is exposed, but may be bound to a random
port on the host. Use the `--publish` command when running the image.

## Example app

A hello world shiny app is given in the `tryit` directory. To try it:

```
cd tryit
docker build --rm -t yourname/shiny-helloworld .
docker run -d --publish=0.0.0.0:49194:5555 yourname/shiny-helloworld 
```

Then go to http://0.0.0.0:49194 to view the app

## Options

Further relevant options can be passed as arguments to the shiny command on
run. The canonical list is in the `runapp.r` file, but should include at least:

```
-d DISPLAYMODE --displaymode=DISPLAYMODE   Launch the app with the given display.mode [default: normal]
-q --quiet                                 Launch app with quiet option.
-r --reactlog                              Set options to show shiny.reactlog.
```

Thus to run an app in 'showcase' mode with the cool reactlog, try:

```
docker run -d --publish=0.0.0.0:49194:5555 yourname/shiny-helloworld --reactlog "--displaymode=showcase"
```


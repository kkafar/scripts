### Scripts

#### Useful

* [`init-proj.sh`](src/init-proj.sh)

#### Utility

* [`return-codes.sh`](src/return-codes.sh)
* [`templ-paths.sh`](src/templ-paths.sh)
* [`utils.sh`](src/utils.sh)

### Installation

1. Some scripts depend on `SCRIPTS_DIR` environment variable being defined,
   therefore put this in your `.bashrc`/`.zshrc`/`...`:

	```bash
	export SCRIPTS_DIR=<path-to-this-repository>
	```

2. To simpify usage of the scripts you may create symlinks:

	```bash
	ln -s <path-to-particular-script> <path-to-some-PATH-folder>/<script-name>
	```

	for example

	```bash
	ln -s $SCRIPTS_DIR/src/init-cpp.sh init-cpp
	```

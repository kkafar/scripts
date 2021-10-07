### Installation

1. Some scripts depend on `SCRIPTS_DIR` environment variable being defined,
   therefore put this in your `.bashrc`/`.zshrc`/`...`:

	```bash
	export SCRIPTS_DIR=<path-to-this-repository>
	```

2. To simpify calling scripts create symlinks:

	```bash
	ln -s <path-to-particular-script> <script-name>
	```

	for example

	```bash
	ln -s $SCRIPTS_DIR/src/init-cpp.sh init-cpp
	```

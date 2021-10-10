### Scripts

#### Useful

* [`init-proj`](src/init-proj.sh)

#### Utility

* [`return-codes`](src/return-codes.sh)
* [`templ-paths`](src/templ-paths.sh)
* [`utils`](src/utils.sh)

### Installation

1. Some scripts depend on `SCRIPTS_DIR` environment variable being defined,
   therefore put this in your `.bashrc`/`.zshrc`/`...`:

	```bash
	export SCRIPTS_DIR=<path-to-this-repository>
	```

2. To simpify usage of the scripts you may want to add `$SCRIPTS_DIR/bin` directory to your `PATH` variable.

  Assuming `SCRIPTS_DIR` variable has been previously defined, put following line in your `.bashrc` / `.zshrc` / `...` file:

  ```bash
  export PATH="$PATH:$SCRIPTS_DIR/bin`
  ```

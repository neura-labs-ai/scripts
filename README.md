# scripts

Scripts used internally by the project.

## Using

1. Clone this repository `https://github.com/neura-labs-ai/scripts code`
2. `cd code` and run the `./setup.sh` script.

3. Setup the PATHS in the shell.

```fish
set PATH $PATH ~/.local/bin
set -x LIBTORCH /home/libs/libtorch
set -x LD_LIBRARY_PATH $LIBTORCH/lib $LD_LIBRARY_PATH
```

Read [here](https://github.com/guillaume-be/rust-bert#manual-installation-recommended) if not using fish shell.

3. Next run the `build.sh` script. (Note: Make sure your still in the code directory)
4. `cd ..` and run the `./run.sh` script.

The web server should start with your application running on the config set in the `setup.sh` script.

# Mobcli

> Mobcli is a command line tool for Android developers to automate the building of a Android mono-repo multi project (features team).

## Setup

This application depends on
- Ruby 2.6.0

In order to import and runs this project on Android Studio, please check your
IDE plugins to meet these requirements (avoiding some nasty bugs).

```
./setup.sh
```

Add this project to your `$PATH` for access to the `mobcli` command-line utility.

   * For **bash**:
     ~~~ bash
     $ echo "export PATH=\"$PATH:`pwd`\"" >> ~/.bash_profile
     ~~~

   * For **Ubuntu Desktop**:
     ~~~ bash
     $ echo "export PATH=\"$PATH:`pwd`\"" >> ~/.bashrc
     ~~~

   * For **Zsh**:
     ~~~ zsh
     $ echo "export PATH=\"$PATH:`pwd`\"" >> ~/.zshrc
     ~~~

## Usage

TODO: Write usage instructions here

## Building and running tests

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Questions?

I'm glad to awser, just ping me via email paulononaka@gmail.com 😄

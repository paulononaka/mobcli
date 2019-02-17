# Mobcli

> Mobcli is a command line tool for Android developers to automate the building of a Android mono-repo multi project (features team).

## Todo

- Challenge 2
- Validate if it find no projets
- Unit test mobcli
- Verify if check ./gradlew properties is fine
- Validate that current folder has gradle setup
- Updates Readme

## Requirements

This application depends on:

- Unix systems
- Ruby 2.6.0

## Setup

Run `./setup.sh` or manually add this project to your `$PATH` in order to access the `mobcli` command-line utility from anywhere:

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

```
Usage: mobcli build-android [options]
        --filter [application|library]
                                     Filter by application or library
    -h, --help                       Prints this help
```

Example:

```
mobcli build-android --filter library --verbose --stackstrace
```

Output:

```
[f1f627d6] Running ./gradlew android-project1:library-module-1 android-project2:library-module-2 --verbose --stackstrace
```

## Building and running tests

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

## Questions?

I'm glad to answer, just ping me via email paulononaka@gmail.com 😄

# Mobcli

> Mobcli is a command line tool for Android developers to automate the building of a Android mono-repo multi project (features team).

## Todo

- Validate if it find no projets
- Unit test mobcli
- Verify if check ./gradlew properties is fine
- Validate that current folder has gradle setup
- Changes the logic of exiting
- Review Readme

## Requirements

This application depends on:

- Unix systems
- Ruby 2.6.0

## Setup

Run `./setup.sh` and `mobcli` command-line utility will be available from anywhere.

# Usage

## mobcli build-android

```
Usage: mobcli build-android [options]. It assembles applications and libraries from a mono-repo Android multi-project.
        --filter [application|library]
                                     Filter by application or library
    -h, --help                       Prints this help
```

Example:

```
mobcli build-android --filter library --verbose --stackstrace

```

Output example:

```
[f1f627d6] Running ./gradlew android-project1:library-module-1 android-project2:library-module-2 --verbose --stackstrace
```

## mobcli test ls

```
Usage: mobcli test ls [options]. It lists all the unit tests in the JUnit XML report.
        --path [PATH]                List the JUnit tests the have failed based on JUnit XML report
    -h, --help                       Prints this help
```

Example:

```
mobcli test ls --path /path/test_junit_result_1.xml
```

Output example:

```
testNormalFlow
swipeFlow
changeOrientation
```

## mobcli test run

```
Usage: mobcli test run [options]. It runs tests through adb based on a JUnit XML report.
        --path [PATH]                List the JUnit tests the have failed based on JUnit XML report
        --filter [failure|passes]    Filter test by type of result
        --applicationId [applicationId]
                                     Informs the applicationId of the project
    -h, --help                       Prints this help
```

Example:

```
mobcli test run --filter failure --applicationId br.package --path /path/test_junit_result_1.xml
```

Output example:

```
[f6cde24c] Running adb shell am instrument -w -e debug false -e class 'br.com.challenge.test.NewChallenge#swipeFlow,br.com.challenge.test.BaseActivity#changeOrientation' br.package/android.support.test.runner.AndroidJUnitRunner
```

## mobcli test report

```
Usage: mobcli test report [options]. It generates a Json report based on a JUnit XML report.
        --path [PATH]                List the JUnit tests the have failed based on JUnit XML report
    -h, --help                       Prints this help
```

Example:

```
mobcli test report --path /path/test_junit_result_1.xml
```

Output example:

```
{
  "name": "module1-android-api21",
  "total": 3,
  "failures": 2,
  "success": 1
}
```

## Building and running tests

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.

## Questions?

I'm glad to answer, just ping me via email paulononaka@gmail.com 😄

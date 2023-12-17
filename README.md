# PmmpUnit 

This action run your integration tests in workflow using [PmmpUnit](https://github.com/ShockedPlot7560/PmmpUnit)

You **MUST** have this folder structure for your suitetest: 
```
tests/pmmpunit
    shared/data # linked to plugin_data
    suitetest
        a_suite # repeat as many as you have suitetest
            config # will be linked to plugin_data
            plugins # plugins to load for this specific suitetest (in more than your plugin)
            tests # folder containing your tests
```

## Uses

```yaml
- uses: ShockedPlot7560/PmmpUnit-actions
  with:
    # Name of your suitetest to run (folder name in your tests/suitetest to take)
    # REQUIRED
    suite-test: ''

    # Path of your test root (where are located your shared and suitetest folder)
    # Default: tests/pmmpunit
    tests-path: ''

    # PHP version to use. (for the list, see the list in PmmpUnit)
    # Default: 8.1
    php-version: ''

    # If you need to pass an env file, give the path
    # Default: .env
    env-file: ''

    # Timeout before the tests failed, this ensured any infinite loop and overcost
    # If your tests take longer, increase it (in seconds)
    # Default: 60 seconds
    timeout: ''

    # If true, a mysql database will be started in parrallel
    # Default: false
    mysql: ""

    # Define the mysql version to use
    # Default: 8.0
    mysql-version: ''

    # File or folder to mount to mysql
    # Composed of sql file, it can create the database for you
    # Default: ''
    mysql-entrypoint: ''
```

## Outputs

- `failed-tests`: The number of failed tests

## Scenarios

### Use with a test matrix:

```yaml
jobs:
  tests:
    name: Integration tests
    runs-on: ${{ matrix.image }}

    strategy:
      fail-fast: false
      matrix:
        image: [ubuntu-20.04]
        suittest: ["suitetest1", "suitetest2"]
        php: ["8.1", "8.2", "8.3"]

    steps:
        - name: Checkout
          uses: actions/checkout@v4

        - name: Tests
          uses: ShockedPlot7560/PmmpUnit-actions
          with:
            php-version: ${{ matrix.php }}
            suite-test: ${{ matrix.suittest }}
```
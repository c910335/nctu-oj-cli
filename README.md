# NCTU OJ CLI

CLI for [NCTU OJ](https://oj.nctu.me)

## Installation

1. Clone this repository.

```sh
$ git clone https://github.com/c910335/nctu-oj-cli.git
$ cd nctu-oj-cli
```

2. Compile it.

```sh
$ shards build
```

3. Edit the configuration file.

```sh
$ cp config.sample.yml config.yml
$ vim config.yml
```

## Usage

```
$ bin/nctu_oj --help
Usage:
  bin/nctu_oj [flags...] [arg...]

CLI for NCTU OJ (https://oj.nctu.me)

Flags:
  --help      # Displays help for the current command.

Subcommands:
  codes       # Download all AC codes.
  scoreboard  # Generate a scoreboard into scoreboard.html
  testdata    # Upload test data

$ bin/nctu_oj codes --help
Usage:
  bin/nctu_oj codes [flags...] [arg...]

Download all AC codes.

Flags:
  --help               # Displays help for the current command.
  --problem-id, -p     # Problem ID
  --students-only, -s  # Only download student's codes

$ bin/nctu_oj scoreboard --help
Usage:
  bin/nctu_oj scoreboard [flags...] [arg...]

Generate a scoreboard into scoreboard.html

Flags:
  --help                                     # Displays help for the current command.
  --judge, -j (default: "pass")              # Judge type (must be pass or score)
  --message, -m                              # The message on the top of scoreboard
  --output, -o (default: "scoreboard.html")  # Output filename
  --refresh, -r                              # Auto refreshing period

$ bin/nctu_oj testdata --help
Usage:
  bin/nctu_oj testdata [flags...] [arg...]

Upload test data

Flags:
  --clear, -c                     # Delete test data before upload
  --dir, -d                       # Test data dir
  --help                          # Displays help for the current command.
  --memory, -m (default: 262144)  # Memory limit (KB)
  --number, -n (default: 10)      # The number of test data includes sample
  --output, -o (default: 262144)  # Output limit (KB)
  --problem-id, -p                # Problem id
  --reducer, -r (default: "min")  # Reducer for score (must be min or sum)
  --sample, -s (default: 2)       # The number of sample test data
  --time, -t (default: 1000)      # Time limit (ms)
```

## Contributing

1. Fork it (<https://github.com/c910335/nctu-oj-cli/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tatsiujin Chin](https://github.com/c910335) - creator and maintainer

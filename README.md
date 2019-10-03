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
$ bin/nctu_oj 
Usage:
  bin/nctu_oj [flags...] [arg...]

CLI for NCTU OJ (https://oj.nctu.me)

Flags:
  --help      # Displays help for the current command.

Subcommands:
  codes       # Download all AC codes.
  scoreboard  # Generate a scoreboard into scoreboard.html
```

## Contributing

1. Fork it (<https://github.com/c910335/nctu-oj-cli/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Tatsiujin Chin](https://github.com/c910335) - creator and maintainer

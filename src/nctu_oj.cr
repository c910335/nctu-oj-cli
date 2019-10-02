require "admiral"
require "kilt"
require "kilt/slang"
require "yaml"
require "./support/*"
require "./client/*"
require "./commands/scoreboard"

class NCTU::OJ::MainCommand < Admiral::Command
  register_sub_command scoreboard, Scoreboard
  define_help description: "CLI for NCTU OJ (https://oj.nctu.me)"

  def run
    puts help
  end
end

NCTU::OJ::MainCommand.run

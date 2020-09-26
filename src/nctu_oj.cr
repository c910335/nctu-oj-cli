require "admiral"
require "http/client"
require "json"
require "kilt"
require "kilt/slang"
require "yaml"
require "./support/*"
require "./client/models/*"
require "./client/*"
require "./commands/helper"
require "./commands/*"
require "./commands/test_data/*"

class NCTU::OJ::MainCommand < Admiral::Command
  define_help description: "CLI for NCTU OJ (https://oj.nctu.edu.tw)"
  register_sub_command scoreboard, Scoreboard
  register_sub_command codes, Codes
  register_sub_command testdata, TestData

  def run
    puts help
  end
end

NCTU::OJ::MainCommand.run

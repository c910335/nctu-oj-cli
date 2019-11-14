class NCTU::OJ::Scoreboard < Admiral::Command
  include CommandHelper
  define_help description: "Generate a scoreboard into scoreboard.html"
  define_flag output : String, description: "Output filename", short: "o", default: "scoreboard.html"
  define_flag judge : String, description: "Judge type (must be pass or score)", short: "j", default: "pass"
  define_flag message : String, description: "The message on the top of scoreboard", short: "m"
  define_flag refresh : Int64, description: "Auto refreshing period", short: "r"

  def run
    raise "Unknown judge type." unless {"pass", "score"}.includes? flags.judge

    load_config
    pull_users
    pull_submissions

    puts "Processing..."

    judges = Array(Array(Int32?)).new(users.size) do
      Array(Int32?).new(problems.size) { nil }
    end
    multi_submissions.each_with_index do |ss, i|
      ss.each do |s|
        if invalids.includes?({user_id_to_name[s.user_id], s.problem_id})
          judges[user_id_to_i[s.user_id]][i] = 0
        else
          j = judges[user_id_to_i[s.user_id]][i]
          judges[user_id_to_i[s.user_id]][i] = s.score if j.nil? || s.score > j
        end
      end
    end

    student_totals = judges.map { |js| js.map { |j| j.try &.>=(100) ? 1 : 0 }.sum }                              # ameba:disable Lint/UselessAssign
    problem_totals = Array(Int32).new(problems.size) { |i| judges.map { |js| js[i].try &.>=(100) ? 1 : 0 }.sum } # ameba:disable Lint/UselessAssign

    puts "Outputing..."

    judge_type = flags.judge       # ameba:disable Lint/UselessAssign
    message = flags.message        # ameba:disable Lint/UselessAssign
    refresh_period = flags.refresh # ameba:disable Lint/UselessAssign
    File.write(flags.output, Kilt.render("src/views/scoreboard.slang"))
  end
end

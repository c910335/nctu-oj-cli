class NCTU::OJ::Scoreboard < Admiral::Command
  include CommandHelper
  define_help description: "Generate a scoreboard into scoreboard.html"
  define_flag output : String, description: "Output filename", short: "o", default: "scoreboard.html"
  define_flag judge : String, description: "Judge type (must be pass or score)", short: "j", default: "pass"
  define_flag message : String, description: "The message on the top of scoreboard", short: "m"
  define_flag refresh : Int64, description: "Auto refreshing period", short: "r"

  def run # ameba:disable Metrics/CyclomaticComplexity
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
        if invalids.try(&.includes?({user_id_to_name[s.user_id], s.problem_id}))
          judges[user_id_to_i[s.user_id]][i] = 0
        else
          j = judges[user_id_to_i[s.user_id]][i]
          judges[user_id_to_i[s.user_id]][i] = s.score if j.nil? || s.score > j
        end
      end
    end

    judge_type = flags.judge

    student_totals = if judge_type == "pass"
                       judges.map(&.sum { |j| j.try &.>=(100) ? 1 : 0 })
                     else
                       judges.map { |js| js.zip(problems).sum { |j, p| j.try(&.*(p.weight || 1).round(2)) || 0 } }
                     end
    problem_acs = Array(Int32).new(problems.size) { |i| judges.sum { |js| js[i].try &.>=(100) ? 1 : 0 } }
    problem_acs << problem_acs.sum
    unless judge_type == "pass"
      problem_maxes = Array(Int32).new(problems.size) { |i| judges.map { |js| js[i] || 0 }.max } + [student_totals.max] # ameba:disable Lint/UselessAssign
      problem_means = Array(Float64).new(problems.size) { |i| (judges.sum { |js| js[i] || 0 } / judges.size).round(2) } + [(student_totals.sum / student_totals.size).round(2)]
      problem_medians = Array(Int32).new(problems.size) { |i| judges.map { |js| js[i] || 0 }.sort![judges.size // 2] } + [student_totals.sort[student_totals.size // 2]]                                                                   # ameba:disable Lint/UselessAssign
      problem_sds = Array(Float64).new(problems.size) { |i| Math.sqrt(judges.sum { |js| ((js[i] || 0) - problem_means[i])**2 } / judges.size) } + [Math.sqrt(student_totals.sum { |j| (j - problem_means[-1])**2 } / student_totals.size)] # ameba:disable Lint/UselessAssign
    end

    puts "Outputing..."

    message = flags.message        # ameba:disable Lint/UselessAssign
    refresh_period = flags.refresh # ameba:disable Lint/UselessAssign
    File.write(flags.output, Kilt.render("src/views/scoreboard.slang"))
  end
end

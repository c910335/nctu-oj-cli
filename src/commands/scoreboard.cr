class NCTU::OJ::Scoreboard < Admiral::Command
  include CommandHelper
  define_help description: "Generate a scoreboard into scoreboard.html"
  define_flag output_filename : String, description: "Output filename", short: "o", default: "scoreboard.html"

  def run
    load_config
    pull_users
    pull_submissions

    puts "Processing..."

    judges = Array(Array(Bool?)).new(users.size) do
      Array(Bool?).new(problems.size) { nil }
    end
    multi_submissions.each_with_index do |ss, i|
      ss.each do |s|
        judges[user_id_to_i[s.user_id]][i] ||= s.score >= 100 && !invalids.includes?({user_id_to_name[s.user_id], s.problem_id})
      end
    end

    student_totals = judges.map { |js| js.map { |j| j ? 1 : 0 }.sum }                              # ameba:disable Lint/UselessAssign
    problem_totals = Array(Int32).new(problems.size) { |i| judges.map { |js| js[i] ? 1 : 0 }.sum } # ameba:disable Lint/UselessAssign

    puts "Outputing..."

    File.write(flags.output_filename, Kilt.render("src/views/scoreboard.slang"))
  end
end

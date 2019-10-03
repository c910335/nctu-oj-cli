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
        judges[user_id_to_i[s.user_id]][i] ||= s.score >= 100
      end
    end
    totals = judges.map { |js| js.map { |j| j ? 1 : 0 }.sum }

    puts "Outputing..."

    output_filename = if o = flags.output_filename
                        o
                      else
                        "scoreboard.html"
                      end

    File.write(output_filename, Kilt.render("src/views/scoreboard.slang"))
  end
end

class NCTU::OJ::Rejudge < Admiral::Command
  include CommandHelper
  define_help description: "Rejudge"
  define_flag problem_id : Int32, description: "Problem ID", short: "p"
  define_flag verdict : String, description: "Verdict", short: "v"
  define_flag students_only : Bool, description: "Only rejudge student's submissions", short: "s", default: false

  def run
    load_config
    pull_users

    problem_id = if p = flags.problem_id
                   p
                 else
                   print "Problem ID: "
                   gets
                 end.to_s

    verdict = if v = flags.verdict
                v
              else
                print "Verdict: "
                gets
              end.to_s

    pull_submissions problem_id, verdict: verdict, student_only: flags.students_only, judged_only: false

    puts "#{submissions.size} submission#{submissions.size > 1 ? "s" : ""} to be rejudged."

    submissions.each_with_index do |submission, i|
      puts "  #{i + 1}. Rejudging #{submission.id}..."
      client.rejudge(submission.id)
      loop do
        sleep 5
        submission = client.submission(submission.id)
        break unless submission.verdict.pending?
      end
    end
  end
end

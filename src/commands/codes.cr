class NCTU::OJ::Codes < Admiral::Command
  include CommandHelper
  define_help description: "Download all AC codes."
  define_flag problem_id : Int32, description: "Problem ID", short: "p"

  def run
    load_config

    problem_id = if p = flags.problem_id
                   p
                 else
                   print "Problem ID: "
                   gets
                 end.to_s

    pull_users
    pull_submissions problem_id, pass_only: true

    puts "Pulling codes..."

    Dir.mkdir_p(problem_id)

    submissions.each do |s|
      File.write("#{problem_id}/#{user_id_to_name[s.user_id]}_#{s.id}.#{client.execute(s.execute_id).extension}", client.file(s.id))
    end
  end
end

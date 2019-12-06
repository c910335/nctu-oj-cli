class NCTU::OJ::TestData
  class Download < Admiral::Command
    include CommandHelper
    define_help description: "Download test data."
    define_flag problem_id : Int32, description: "Problem ID", short: "p"

    def run
      load_config

      problem_id = if p = flags.problem_id
                     p
                   else
                     print "Problem ID: "
                     gets
                   end.to_s

      puts "Pulling test data..."

      Dir.mkdir_p(problem_id)

      client.test_data(problem_id).each_with_index do |test_datum, i|
        File.write("#{problem_id}/input#{i + 1}.txt", client.input_file(test_datum.id))
        File.write("#{problem_id}/output#{i + 1}.txt", client.output_file(test_datum.id))
        print "#{i + 1}.."
      end
    end
  end

  register_sub_command download, Download
end

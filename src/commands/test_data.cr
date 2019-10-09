class NCTU::OJ::TestData < Admiral::Command
  include CommandHelper
  define_help description: "Upload test data"
  define_flag problem_id : Int32, description: "Problem id", short: "p"
  define_flag dir : String, description: "Test data dir", short: "d"
  define_flag number : Int32, description: "The number of test data", default: 10, short: "n"
  define_flag sample : Int32, description: "The count of sample test data", default: 2, short: "s"
  define_flag clear : Bool, description: "Delete test data before upload", default: false, short: "c"
  define_flag time : Int32, description: "Time limit (ms)", default: 1000, short: "t"
  define_flag memory : Int32, description: "Memory limit (KB)", default: 262144, short: "m"
  define_flag output : Int32, description: "Output limit (KB)", default: 262144, short: "o"

  def run
    load_config

    problem_id = if p = flags.problem_id
                   p
                 else
                   print "Problem ID: "
                   gets.to_s.to_i
                 end

    dir = if d = flags.dir
            d
          else
            print "Test Data Dir: "
            gets.to_s
          end

    number, sample, clear, time, memory, output = flags.number, flags.sample, flags.clear, flags.time, flags.memory, flags.output

    if clear
      puts "Clearing..."
      client.clear_test_data(problem_id)
    end

    puts "Uploading..."

    (1..number).each do |i|
      client.upload_test_data(
        problem_id,
        i <= sample,
        File.new("#{dir}/input#{i}.txt"),
        File.new("#{dir}/output#{i}.txt"),
        time,
        memory,
        output,
        100
      )
      print "i.."
    end
  end
end

class NCTU::OJ::TestData < Admiral::Command
  include CommandHelper
  define_help description: "Upload test data"
  define_flag problem_id : Int32, description: "Problem id", short: "p"
  define_flag dir : String, description: "Test data dir", short: "d"
  define_flag number : Int32, description: "The number of test data includes sample", default: 10, short: "n"
  define_flag sample : Int32, description: "The number of sample test data", default: 2, short: "s"
  define_flag clear : Bool, description: "Delete test data before upload", default: false, short: "c"
  define_flag time : Int32, description: "Time limit (ms)", default: 1000, short: "t"
  define_flag memory : Int32, description: "Memory limit (KB)", default: 262144, short: "m"
  define_flag output : Int32, description: "Output limit (KB)", default: 262144, short: "o"
  define_flag reducer : String, description: "Reducer for score (must be min or sum)", default: "min", short: "r"

  def run
    raise "Unknown reducer." unless {"min", "sum"}.includes? flags.reducer

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

    number, sample, clear, time, memory, output, reducer = flags.number, flags.sample, flags.clear, flags.time, flags.memory, flags.output, flags.reducer

    if clear
      puts "Clearing..."
      client.clear_test_data(problem_id)
    end

    puts "Uploading..."

    score, border = if reducer == "min"
                      {100, 0}
                    else
                      {100 // (number - sample), number - 100 % (number - sample) + 1}
                    end

    (1..number).each do |i|
      s = if reducer == "min"
            100
          elsif i <= sample
            0
          else
            score += 1 if i == border
            score
          end
      client.upload_test_data(
        problem_id,
        i <= sample,
        File.new("#{dir}/input#{i}.txt"),
        File.new("#{dir}/output#{i}.txt"),
        time,
        memory,
        output,
        s
      )
      print "#{i}.."
    end
  end
end

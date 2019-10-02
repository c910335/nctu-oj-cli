class NCTU::OJ::Scoreboard < Admiral::Command
  def run
    puts "Initializing..."

    config = Config.from_yaml(File.read("config.yml"))
    problems = config.problems
    students = config.students
    group_id = config.group_id
    client = Client.new(config.token, group_id)

    puts "Pulling users..."

    users = client.users.select! { |u| students.includes? u.name }.sort_by! &.name
    user_id_to_i = users.map_with_index { |u, i| {u.id, i} }.to_h

    puts "Pulling submissions..."

    submissions = problems.map do |p|
      client.submissions(p.id).select! do |s|
        s.created_at < p.deadline && user_id_to_i[s.user_id]?
      end
    end

    puts "Processing..."

    judges = Array(Array(Bool?)).new(users.size) do
      Array(Bool?).new(problems.size) { nil }
    end
    submissions.each_with_index do |ss, i|
      ss.each do |s|
        judges[user_id_to_i[s.user_id]][i] ||= s.score >= 100
      end
    end
    totals = judges.map { |js| js.map { |j| j ? 1 : 0 }.sum }

    puts "Outputing..."

    File.write("scoreboard.html", Kilt.render("src/views/scoreboard.slang"))
  end
end

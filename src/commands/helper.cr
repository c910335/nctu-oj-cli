module NCTU::OJ::CommandHelper
  property! config : Config
  property! invalids : Array(Config::Invalid)
  property! problems : Array(Config::Problem)
  property! students : Array(String)
  property! group_id : Int32
  property! title : String
  property! client : Client
  property! users : Array(User)
  property! user_id_to_i : Hash(Int32, Int32)
  property! user_id_to_name : Hash(Int32, String)
  property! multi_submissions : Array(Array(Submission))
  property! submissions : Array(Submission)

  def load_config
    puts "Initializing..."
    @config = Config.from_yaml(File.read("config.yml"))
    @invalids = config.invalids
    @problems = config.problems
    @students = config.students
    @group_id = config.group_id
    @title = config.title
    @client = Client.new(config.token, group_id)
  end

  def pull_users
    puts "Pulling users..."
    @users = client.users
    @user_id_to_name = users.map { |u| {u.id, u.name} }.to_h
    users.select! { |u| students.includes? u.name }.sort_by! &.name
    @user_id_to_i = users.map_with_index { |u, i| {u.id, i} }.to_h
  end

  def pull_submissions(problems : Array(Config::Problem) = self.problems, student_only : Bool = true, pass_only : Bool = false)
    puts "Pulling submissions..."
    @multi_submissions = problems.map do |p|
      client.submissions(p.id).select! do |s|
        f = s.created_at <= p.deadline
        f &&= user_id_to_i[s.user_id]? if student_only
        f &&= s.ac? if pass_only
        f &&= p.ips!.includes?(client.submission(s.id).ip) unless p.ips.nil? || p.ips!.empty?
        f
      end
    end
  end

  def pull_submissions(problem_id : String | Int32, student_only : Bool = true, pass_only : Bool = false)
    @submissions = pull_submissions(self.problems.select { |p| p.id == problem_id.to_i }, student_only, pass_only).first
  end
end

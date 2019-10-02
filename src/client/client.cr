require "http/client"
require "json"
require "./models/*"

class NCTU::OJ::Client
  VERSION = "0.1.0"

  @cookie : String
  @group_id : String
  @client = HTTP::Client.new("api.oj.nctu.me", tls: true)
  @executes = {} of Int32 => Execute

  def initialize(token, group_id)
    @cookie = "token=#{token}"
    @group_id = group_id.to_s
  end

  def users
    Array(User).from_json(JSON.parse(get("/groups/#{@group_id}/users/", {"count" => ["99999"]}).body)["msg"].to_json)
  end

  def problems
    Array(Problem).from_json(JSON.parse(get("/groups/#{@group_id}/problems/", {"count" => ["99999"]}).body)["msg"]["data"].to_json)
  end

  def submissions(problem_id)
    Array(Submission).from_json(JSON.parse(get("/submissions/", {"problem_id" => [problem_id.to_s], "group_id" => [@group_id], "count" => ["99999"]}).body)["msg"]["submissions"].as_a.select! { |s| s["score"].as_i? }.to_json)
  end

  def execute(id)
    return @executes[id] if @executes[id]?
    @executes[id] = Execute.from_json(JSON.parse(get("/executes/#{id}/").body)["msg"].to_json)
  end

  def file(submission_id)
    get("/submissions/#{submission_id}/file/").body
  end

  def get(path : String, params : Hash(String, Array(String)))
    get(path, HTTP::Params.new(params))
  end

  def get(path : String, params : HTTP::Params? = nil)
    path += "?#{params}" if params
    @client.get(path, HTTP::Headers{"Cookie" => @cookie})
  end
end

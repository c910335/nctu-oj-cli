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

  def test_data(problem_id)
    Array(TestDatum).from_json(JSON.parse(get("/problems/#{problem_id}/testdata/").body)["msg"].to_json)
  end

  def clear_test_data(problem_id)
    test_data(problem_id).each do |test_datum|
      delete("/testdata/#{test_datum.id}/")
    end
  end

  def upload_test_data(problem_id, sample, input, output, time_limit, memory_limit, output_limit, score)
    io = IO::Memory.new
    builder = HTTP::FormData::Builder.new(io, "e271dad0e33795908c84")
    builder.field("problem_id", problem_id)
    builder.field("sample", sample)
    builder.file("input", input, HTTP::FormData::FileMetadata.new(filename: "input"))
    builder.file("output", output, HTTP::FormData::FileMetadata.new(filename: "output"))
    builder.field("time_limit", time_limit)
    builder.field("memory_limit", memory_limit)
    builder.field("output_limit", output_limit)
    builder.field("score", score)
    builder.finish
    io.rewind

    post("/testdata/", io, builder.content_type)
  end

  def submissions(problem_id)
    Array(Submission).from_json(JSON.parse(get("/submissions/", {"problem_id" => [problem_id.to_s], "group_id" => [@group_id], "count" => ["99999"]}).body)["msg"]["submissions"].as_a.select! { |s| s["score"].as_i? }.to_json)
  end

  def submission(id)
    Submission::Detailed.from_json(JSON.parse(get("/submissions/#{id}/").body)["msg"].to_json)
  end

  def execute(id)
    return @executes[id] if @executes[id]?
    begin
      @executes[id] = Execute.from_json(JSON.parse(get("/executes/#{id}/").body)["msg"].to_json)
    rescue JSON::MappingError
      nil
    end
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

  def post(path : String, body : Hash | IO, content_type : String = nil)
    headers = HTTP::Headers{"Cookie" => @cookie}
    headers.add("Content-Type", content_type) if content_type
    case body
    when Hash
      @client.post(path, headers, form: body)
    when IO
      @client.post(path, headers, body: body)
    end
  end

  def delete(path : String)
    @client.delete(path, HTTP::Headers{"Cookie" => @cookie})
  end
end

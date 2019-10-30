class NCTU::OJ::Submission
  include JSON::Serializable
  property id : Int32
  property user_id : Int32
  property problem_id : Int32
  property verdict_id : Int32
  property execute_id : Int32
  property score : Int32
  property length : Int32
  property time_usage : Int32
  property memory_usage : Int32
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property created_at : Time
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property updated_at : Time

  def ac?
    @verdict_id == 10
  end

  class Detailed < Submission
    property filename : String
    property ip : String
  end
end

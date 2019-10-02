class Submission
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
  @[JSON::Field(converter: NCTU::OJ::Time)]
  property created_at : ::Time
  @[JSON::Field(converter: NCTU::OJ::Time)]
  property updated_at : ::Time
end

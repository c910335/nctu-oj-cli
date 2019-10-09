class NCTU::OJ::TestDatum
  include JSON::Serializable
  property id : Int32
  property problem_id : Int32
  property sample : Bool
  property time_limit : Int32
  property memory_limit : Int32
  property output_limit : Int32
  property score : Int32
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property created_at : Time
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property updated_at : Time
end

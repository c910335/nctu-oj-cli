require "json"

class NCTU::OJ::Problem
  include JSON::Serializable
  property id : Int32
  property title : String
  property source : String
  property user_id : Int32
  property status : Int32
  property visible : Bool
  property group_read : Bool
  property group_write : Bool
  @[JSON::Field(converter: NCTU::OJ::Time)]
  property created_at : ::Time
  @[JSON::Field(converter: NCTU::OJ::Time)]
  property updated_at : ::Time
end

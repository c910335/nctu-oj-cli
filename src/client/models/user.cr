class User
  include JSON::Serializable
  property id : Int32
  property name : String
  property powers : Array(Int32)
end

class NCTU::OJ::Config
  include YAML::Serializable

  property token : String
  property group_id : Int32
  property title : String
  property invalids : Array(Invalid)
  property students : Array(String)
  property problems : Array(Problem)

  class Problem
    include YAML::Serializable

    property id : Int32
    @[YAML::Field(converter: NCTU::OJ::TimeConverter)]
    property deadline : Time?
    property ips : Array(String)?

    def ips!
      ips.not_nil!
    end
  end

  class Invalid
    include YAML::Serializable

    property student_id : String
    property problem_id : Int32

    def equals?(sid, pid)
      @student_id == sid && @problem_id == pid
    end

    def ==(other)
      equals?(other[0], other[1])
    end
  end
end

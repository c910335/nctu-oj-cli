class NCTU::OJ::Config
  class Problem
    YAML.mapping(
      id: Int32,
      deadline: {type: Time?, converter: TimeConverter},
      ips: Array(String)?
    )

    def ips!
      ips.not_nil!
    end
  end

  class Invalid
    YAML.mapping(
      student_id: String,
      problem_id: Int32
    )

    def equals?(sid, pid)
      @student_id == sid && @problem_id == pid
    end

    def ==(other)
      equals?(other[0], other[1])
    end
  end

  YAML.mapping(
    token: String,
    group_id: Int32,
    title: String,
    invalids: Array(Invalid),
    students: Array(String),
    problems: Array(Problem)
  )
end

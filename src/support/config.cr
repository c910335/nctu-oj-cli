class NCTU::OJ::Config
  class Problem
    YAML.mapping(
      id: Int32,
      deadline: {type: ::Time, converter: NCTU::OJ::Time}
    )
  end

  YAML.mapping(
    token: String,
    group_id: Int32,
    students: Array(String),
    problems: Array(Problem)
  )
end

module NCTU::OJ::Time
  @@tf = ::Time::Format.new("%F %T", ::Time::Location.local)

  def self.from_yaml(ctx : YAML::ParseContext, node : YAML::Nodes::Node) : ::Time
    unless node.is_a?(YAML::Nodes::Scalar)
      node.raise "Expected scalar, not #{node.class}"
    end

    @@tf.parse(node.value)
  end

  def self.to_yaml(value : Time, yaml : YAML::Builder)
    @@tf.format(value).to_yaml(yaml)
  end

  def self.from_json(pull : JSON::PullParser)
    @@tf.parse(pull.read_string)
  end

  def self.to_json(value : ::Time, json : JSON::Builder)
    @@tf.format(value).to_json(json)
  end
end

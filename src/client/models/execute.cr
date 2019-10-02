class NCTU::OJ::Execute
  include JSON::Serializable

  EXTENSIONS = %w(c cpp java py py)

  property name : String
  property problem_id : Int32
  property language_id : Int32

  def extension
    EXTENSIONS[language_id - 1]
  end
end

class NCTU::OJ::Submission
  include JSON::Serializable
  property id : Int32
  property user_id : Int32
  property problem_id : Int32
  property verdict_id : Int32
  @[JSON::Field(ignore: true)]
  setter verdict : Verdict?
  property execute_id : Int32
  property! score : Int32
  property length : Int32
  property! time_usage : Int32
  property! memory_usage : Int32
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property created_at : Time
  @[JSON::Field(converter: NCTU::OJ::TimeConverter)]
  property updated_at : Time

  delegate pending?, ac?, to: verdict

  def verdict
    @verdict ||= Verdict.new(verdict_id)
  end

  class Detailed < Submission
    property filename : String
    property ip : String
  end

  enum Verdict
    AllVerdict
    Pending
    Judging
    SE
    CE
    RE
    MLE
    TLE
    OLE
    WA
    AC
  end
end

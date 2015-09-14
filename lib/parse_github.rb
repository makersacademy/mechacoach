class ParseGithub
  def self.with(payload)
    parse_payload(payload)
  end

  private

  def self.parse_payload(payload)
    raise 'I can only deal with brand new issues.' unless issue_just_opened?(payload)
    JSON.parse(payload)["issue"]["number"]
  end

  def self.issue_just_opened?(payload)
    JSON.parse(payload)["action"] == "opened"
  end
end
class ParseGithub
  def self.with(payload)
    parse_payload(payload)
  end

  private

  def self.parse_payload(payload)
    JSON.parse(payload)["issue"]["number"]
  end
end
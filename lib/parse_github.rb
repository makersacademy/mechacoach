class ParseGithub
  def self.with(payload)
    parse_payload(payload)
  end

  private

  def self.parse_payload(payload)
    payload[:issue][:number].to_i
  end
end
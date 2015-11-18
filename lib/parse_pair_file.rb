class ParsePairFile
  def self.with(file)
    begin
      JSON.parse(file.read)
    rescue JSON::ParserError
    end
  end
end

class ParsePairFile
  def self.with(file)
    begin
      JSON.parse(File.open(file, 'r').read)
    rescue JSON::ParserError
    end
  end
end
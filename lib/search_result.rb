class SearchResult
  ORG_NAME = "https://github.com/makersacademy/"
  def initialize(data)
    @data = data
  end

  def summary
    """
      Total count: #{count}\n\n
      Locations found\n #{paths.join("\n")}
    """
  end

  private

  def count
    @data[:total_count]
  end

  def paths
    @data[:items].map { |item| ORG_NAME + item[:repository][:name] + "/blob/master/" + item[:path] }
  end
end

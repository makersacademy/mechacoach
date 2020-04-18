class SearchResult
  ORG_NAME = "https://github.com/makersacademy/"

  def initialize(data, summary)
    @summary = summary
    @data = data
  end

  def summary
    @summary
  end

  def body
    """
    #{count} files found.\n
    #{paths.join("\n")}
    """
  end

  private

  attr_reader :data

  def count
    data[:total_count]
  end

  def paths
    data[:items].map { |item| ORG_NAME + item[:repository][:name] + "/blob/master/" + item[:path] }
  end
end

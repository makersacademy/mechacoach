class ReviewSummary
  attr_reader :content, :name, :github_user, :reviewer, :headings

  def initialize(content:, name:, github_user:, headings:)
    @content = content
    @name = name
    @github_user = github_user
    @headings = headings
    @reviewer = @content['yourname']
  end

  def good_parts
    good_headings = headings.keys.select { |key| has_content_for?(key) }
    good_headings.map { |key| content[key] }
  end

  def needs_improvement
    ni_headings = headings.keys.reject { |key| has_content_for?(key) }
    ni_headings.map { |key| headings[key] }
  end

  def has_additional_comments?
    has_content_for?('anyadditionalcommentsonthecodeyoureviewed')
  end

  def additional_comments
    content['anyadditionalcommentsonthecodeyoureviewed']
  end

  def get_binding
    binding
  end

  private

  def has_content_for?(key)
    content[key] && !content[key].empty?
  end
end
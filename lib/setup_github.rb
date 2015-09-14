class SetupGithub
  def self.with(github_klass)
    github_klass.new(github_auth_hash)
  end

  private

  def self.github_auth_hash
    {
      :login => ENV['GITHUB_USERNAME'], 
      :password => ENV['GITHUB_PASSWORD']
    }
  end
end
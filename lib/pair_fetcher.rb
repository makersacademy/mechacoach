require 'json'
require 'pair_loader'

class PairFetcher
  def self.call(cohort)
    JSON.parse(redis.get("#{cohort}_pairs"))
  end

  private

  def self.redis
    Redis.new
  end
end
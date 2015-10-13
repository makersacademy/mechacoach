require 'json'
require 'pair_loader'

class PairFetcher
  def self.call(cohort)
    JSON.parse(redis.get("#{cohort}_pairs"))
  end

  def self.call_and_pop(cohort)
    pairs_today = call.pop
    PairLoader.call(cohort, call(cohort))
    pairs_today
  end

  private

  def self.redis
    Redis.new
  end
end
require 'redis'

class PairTracker
  def self.index(cohort)
    redis.get("#{cohort}_index").to_i
  end

  def self.increment(cohort)
    redis.incr("#{cohort}_index").to_i
  end

  private

  def self.redis
    Redis.new
  end
end
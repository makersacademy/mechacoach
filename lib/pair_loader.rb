class PairLoader
  attr_reader :pairs

  def initialize(pairs)
    @pairs = pairs
  end

  def self.call(cohort, pairs)
    new(pairs).commit(cohort)
  end

  def commit(cohort)
    redis = connect_redis
    redis.set("#{cohort}_pairs", pairs.to_json)
  end

  private

  def connect_redis
    Redis.new
  end
end
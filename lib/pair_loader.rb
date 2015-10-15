class PairLoader
  attr_reader :pairs

  def initialize(pairs)
    @pairs = pairs
  end

  def self.call(cohort, pairs)
    new(pairs).commit(cohort)
  end

  def commit(cohort)
    redis.set("#{cohort}_pairs", pairs.to_json)
  end

  private

  def redis
    Redis.new
  end
end
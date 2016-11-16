class PairAssignments

  INDEX_KEY = ->(cohort){ "#{cohort}_index" }
  PAIRS_KEY = ->(cohort){ "#{cohort}_pairs" }

  class << self

    def repo
      Redis.new
    end

    def find(cohort)
      data = repo.get(PAIRS_KEY.call(cohort))
      return nil unless data
      PairAssignments.new(cohort, JSON.parse(data))
    end

    def create(cohort, assignments)
      repo.set(PAIRS_KEY.call(cohort), assignments.to_json)
      repo.set(INDEX_KEY.call(cohort), 0)
    end
  end

  attr_reader :cohort

  def initialize(cohort, assignments_array)
    @cohort = cohort
    @assignments = assignments_array
  end


  def next
    @assignments[index]
  ensure
    PairAssignments.repo.incr(index_key)
  end

  private

  def index_key
    INDEX_KEY.call(cohort)
  end

  def index
    PairAssignments.repo.get(index_key).to_i % @assignments.count
  end
end

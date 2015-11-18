class PairAssignments
  def self.repo
    Redis.new
  end

  class << self
    def find(cohort)
      data = repo.get(pairs_key(cohort))
      return nil unless data
      PairAssignments.new(cohort, JSON.parse(data))
    end

    def create(cohort, assignments)
      repo.set(pairs_key(cohort), assignments.to_json)
    end

    private

    def pairs_key(cohort)
      "#{cohort}_pairs"
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
    "#{cohort}_index"
  end

  def index
    PairAssignments.repo.get(index_key).to_i % @assignments.count
  end
end

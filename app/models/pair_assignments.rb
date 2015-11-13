class PairAssignments
  def self.repo
    Redis.new
  end

  def self.find(cohort)
    data = repo.get("#{cohort}_pairs")
    return nil unless data
    PairAssignments.new(cohort, JSON.parse(repo.get("#{cohort}_pairs")))
  end

  attr_reader :cohort

  def initialize(cohort, assignments_array)
    @cohort = cohort
    @assignments = assignments_array
  end


  def next
    @assignments[index]
  ensure
    PairAssignments.repo.incr("#{cohort}_index")
  end

  private

  def index
    PairAssignments.repo.get("#{cohort}_index").to_i % @assignments.count
  end
end

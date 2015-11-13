class ReleasePairs
  def self.with(cohort:)
    service = ReleasePairs.new(cohort: cohort)
    service.run
  end

  attr_reader :cohort

  def initialize(cohort:)
    @cohort = cohort
  end

  def run
    assignments = PairAssignments.find(cohort)
    SlackNotifier.new(channel: cohort_channel).notify(message(assignments))
  end

  private

  def message(assignments)
    pairs = assignments.next.map{|a| a.join(", ")}.join("\n")
    "pairs:\n\n#{pairs}"
  end

  def cohort_channel
    "##{cohort}"
  end
end

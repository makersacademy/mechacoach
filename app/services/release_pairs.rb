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
    SlackNotifier.new(channel: cohort_channel, team: TEAM).notify(message(assignments))
  end

  private

  TEAM = 'makersstudents'

  def message(assignments)
    pairs = assignments.next.map{|a| a.join(", ")}.join("\n")
    "@channel your pair assignments for tomorrow:\n\n#{pairs}"
  end

  def cohort_channel
    "##{cohort}"
  end
end

class ReleasePairs
  DEFAULT_TEAM = 'makersstudents'

  def self.with(team: DEFAULT_TEAM, cohort:)
    service = new(team: team, cohort: cohort)
    service.run
  end

  attr_reader :team, :cohort

  def initialize(team:, cohort:)
    @team = team
    @cohort = cohort
  end

  def run
    assignments = PairAssignments.find(cohort)
    SlackNotifier.new(team: team, channel: cohort_channel).notify(message(assignments))
  end

  private

  def message(assignments)
    pairs = assignments.next.map{|a| a.join(", ")}.join("\n")
    "<!channel> assignments for your next pairing session:\n\n#{pairs}"
  end

  def cohort_channel
    "##{cohort}"
  end
end

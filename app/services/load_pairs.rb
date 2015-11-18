class LoadPairs
  def self.with(cohort:, file:)
    service = LoadPairs.new(cohort: cohort, file: file)
    service.run
  end

  attr_reader :cohort, :file

  def initialize(cohort:, file:)
    @cohort = cohort
    @file = file
  end

  def run
    pairs = ParsePairFile.with(file)
    PairAssignments.create(cohort, pairs)
  end
end

describe ReviewSummary do

  review = YAML.load(File.read('./spec/fixtures/submit_challenge_review_data.yml'))
  meta =  YAML.load(File.read('./spec/fixtures/submit_challenge_meta_data.yml'))
  content = review.merge(meta)

  # headings in the real system is a lookup table with entries like so
  # 'appropriateuseofdependencyinjection' => 'Appropiate Use of Dependency Injection'
  let(:headings) { Hash[content.keys.map{ |k| [k,k.upcase] }] }

  subject(:summary) { described_class.new(content: content, name: 'test_challenge', github_user: 'test_user', headings: headings) }

  it 'provides the name of the challenge' do
    expect(summary.name).to eq 'test_challenge'
  end

  it 'provides the reviewer of the challenge' do
    expect(summary.reviewer).to eq 'Jongmin Kim'
  end

  it 'lists the good parts' do
    good_parts = review.values.reject { |content| content.empty? }
    # require 'byebug' ; byebug
    good_parts.each do |content|
      expect(summary.good_parts).to include content
    end
  end

  it 'does not include needs improvement in good parts' do
    needs_improvement = review.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(summary.good_parts).not_to include content
    end
  end

  it 'lists the parts needing improvement' do
    # the needs_improvement headings will come from the google doc.
    # the mock of this just returns the uppercase of the key to prove it is called.
    needs_improvement = review.select { |key, content| content.empty? }.map { |key, content| key.upcase }
    needs_improvement.each do |content|
      expect(summary.needs_improvement).to include content
    end
  end

  it 'does not include good parts in needing improvement' do
    good_parts = review.values.reject { |content| content.empty? }
    good_parts.each do |content|
      expect(summary.needs_improvement).not_to include content.upcase
    end
  end

  it 'knows if there are additional comments' do
    expect(summary).to have_additional_comments
  end
end

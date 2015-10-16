require 'pair_loader'
require 'redis'

describe PairLoader do
  let(:redis) { Redis.new }

  before do
    Redis.new.set('october_2015_pairs', nil)
  end

  describe '.call' do
    it 'commits pairs to a database' do
      described_class.call(:october_2015, october_2015_pairs)
      expect(JSON.parse(redis.get('october_2015_pairs'))).to eq october_2015_pairs
    end
  end

  private

  def october_2015_pairs
    [
      [
        ["Ivan", "Octavian"],
        ["Amy", "Rob"],
        ["Radu", "Chuka"],
        ["Eleni", "Aaron"],
        ["Mattia", "Edward"],
        ["Mari-Ann", "Rajeev"],
        ["Hamza", "Fergus"],
        ["George", "Sam"],
        ["Raphael", "Julien"],
        ["Mateja", "Andrew"],
        ["Mahmudh", "Alaan"],
        ["Rebecca", "Deon"],
        ["Dovile", "Ezzy"]
      ],
      [
        ["Ivan", "Amy"],
        ["Octavian", "Rob"],
        ["Radu", "Eleni"],
        ["Chuka", "Aaron"],
        ["Mattia", "Mari-Ann"],
        ["Edward", "Rajeev"],
        ["Hamza", "George"],
        ["Fergus", "Sam"],
        ["Raphael", "Mateja"],
        ["Julien", "Andrew"],
        ["Mahmudh", "Rebecca"],
        ["Alaan", "Dovile"],
        ["Deon", "Ezzy"]
      ],
      [
        ["Ivan", "Rob"],
        ["Octavian", "Amy"],
        ["Radu", "Aaron"],
        ["Chuka", "Eleni"],
        ["Mattia", "Rajeev"],
        ["Edward", "Mari-Ann"],
        ["Hamza", "Sam"],
        ["Fergus", "George"],
        ["Raphael", "Andrew"],
        ["Julien", "Mateja"],
        ["Mahmudh", "Deon"],
        ["Alaan", "Ezzy"],
        ["Rebecca", "Dovile"]
      ],
      [
        ["Ivan", "Radu"],
        ["Octavian", "Chuka"],
        ["Amy", "Eleni"],
        ["Rob", "Aaron"],
        ["Mattia", "Hamza"],
        ["Edward", "Fergus"],
        ["Mari-Ann", "George"],
        ["Rajeev", "Sam"],
        ["Raphael", "Mahmudh"],
        ["Julien", "Alaan"],
        ["Mateja", "Rebecca"],
        ["Andrew", "Ezzy"],
        ["Deon", "Dovile"]
      ],
      [
        ["Ivan", "Chuka"],
        ["Octavian", "Radu"],
        ["Amy", "Aaron"],
        ["Rob", "Eleni"],
        ["Mattia", "Fergus"],
        ["Edward", "Hamza"],
        ["Mari-Ann", "Sam"],
        ["Rajeev", "George"],
        ["Raphael", "Alaan"],
        ["Julien", "Mahmudh"],
        ["Mateja", "Deon"],
        ["Rebecca", "Ezzy"],
        ["Andrew", "Dovile"]
      ],
      [
        ["Amy", "Rebecca"],
        ["Fergus", "Mateja"],
        ["Aaron", "Mari-Ann"],
        ["Chuka", "Andrew"],
        ["Rob", "Raphael"],
        ["Ivan", "Mahmudh"],
        ["George", "Dovile"],
        ["Octavian", "Eleni"],
        ["Edward", "Alaan"],
        ["Hamza", "Ezzy"],
        ["Mattia", "Sam"],
        ["Radu", "Rajeev"],
        ["Julien", "Deon"]
      ],
      [
        ["Octavian", "Mateja"],
        ["Aaron", "Julien"],
        ["Mari-Ann", "Hamza"],
        ["Edward", "Mahmudh"],
        ["Ivan", "Deon"],
        ["Eleni", "George"],
        ["Rob", "Chuka"],
        ["Radu", "Fergus"],
        ["Rajeev", "Alaan"],
        ["Andrew", "Rebecca"],
        ["Amy", "Raphael"],
        ["Sam", "Dovile"],
        ["Mattia", "Ezzy"]
      ],
      [
        ["Aaron", "Rebecca"],
        ["Rob", "Mateja"],
        ["Octavian", "Rajeev"],
        ["Eleni", "Mari-Ann"],
        ["George", "Ezzy"],
        ["Ivan", "Sam"],
        ["Hamza", "Raphael"],
        ["Mattia", "Mahmudh"],
        ["Amy", "Julien"],
        ["Radu", "Dovile"],
        ["Chuka", "Deon"],
        ["Fergus", "Alaan"],
        ["Edward", "Andrew"]
      ],
      [
        ["Aaron", "Fergus"],
        ["George", "Rebecca"],
        ["Rob", "Hamza"],
        ["Eleni", "Dovile"],
        ["Mattia", "Mateja"],
        ["Radu", "Mari-Ann"],
        ["Octavian", "Raphael"],
        ["Rajeev", "Andrew"],
        ["Ivan", "Ezzy"],
        ["Chuka", "Mahmudh"],
        ["Sam", "Julien"],
        ["Edward", "Deon"],
        ["Amy", "Alaan"]
      ],
      [
        ["Octavian", "Julien"],
        ["Chuka", "George"],
        ["Ivan", "Eleni"],
        ["Mari-Ann", "Mahmudh"],
        ["Rajeev", "Raphael"],
        ["Sam", "Ezzy"],
        ["Edward", "Mateja"],
        ["Aaron", "Deon"],
        ["Alaan", "Rebecca"],
        ["Radu", "Andrew"],
        ["Rob", "Mattia"],
        ["Hamza", "Dovile"],
        ["Amy", "Fergus"]
      ],
      [
        ["Rajeev", "Julien"],
        ["Ivan", "Mateja"],
        ["Chuka", "Fergus"],
        ["Mari-Ann", "Dovile"],
        ["Raphael", "Ezzy"],
        ["Amy", "Deon"],
        ["Andrew", "Mahmudh"],
        ["Edward", "Rebecca"],
        ["Eleni", "Hamza"],
        ["Aaron", "Sam"],
        ["Octavian", "George"],
        ["Radu", "Mattia"],
        ["Rob", "Alaan"]
      ],
      [
        ["Ivan", "Aaron"],
        ["Andrew", "Alaan"],
        ["Mari-Ann", "Mateja"],
        ["Hamza", "Mahmudh"],
        ["Raphael", "Deon"],
        ["Amy", "George"],
        ["Rob", "Dovile"],
        ["Radu", "Sam"],
        ["Fergus", "Rebecca"],
        ["Eleni", "Rajeev"],
        ["Octavian", "Edward"],
        ["Julien", "Ezzy"],
        ["Chuka", "Mattia"]
      ],
      [
        ["Aaron", "Hamza"],
        ["Rob", "Rajeev"],
        ["George", "Julien"],
        ["Raphael", "Dovile"],
        ["Ivan", "Alaan"],
        ["Eleni", "Mattia"],
        ["Radu", "Rebecca"],
        ["Mari-Ann", "Ezzy"],
        ["Fergus", "Deon"],
        ["Amy", "Sam"],
        ["Chuka", "Edward"],
        ["Octavian", "Andrew"],
        ["Mateja", "Mahmudh"]
      ],
      [
        ["Julien", "Rebecca"],
        ["Rajeev", "Mahmudh"],
        ["Octavian", "Sam"],
        ["George", "Andrew"],
        ["Chuka", "Dovile"],
        ["Aaron", "Mattia"],
        ["Radu", "Raphael"],
        ["Amy", "Ezzy"],
        ["Eleni", "Fergus"],
        ["Hamza", "Deon"],
        ["Ivan", "Edward"],
        ["Rob", "Mari-Ann"],
        ["Mateja", "Alaan"]
      ],
      [
        ["Amy", "Rajeev"],
        ["Rob", "Edward"],
        ["Octavian", "Mari-Ann"],
        ["Raphael", "Rebecca"],
        ["Mahmudh", "Dovile"],
        ["Mattia", "Julien"],
        ["Alaan", "Deon"],
        ["Sam", "Andrew"],
        ["Aaron", "George"],
        ["Eleni", "Mateja"],
        ["Chuka", "Ezzy"],
        ["Ivan", "Fergus"],
        ["Radu", "Hamza"]
      ],
      [
        ["Mari-Ann", "Rebecca"],
        ["Mattia", "Alaan"],
        ["Rajeev", "Dovile"],
        ["Rob", "Ezzy"],
        ["Octavian", "Hamza"],
        ["Aaron", "Raphael"],
        ["Sam", "Deon"],
        ["Amy", "Mahmudh"],
        ["Radu", "George"],
        ["Fergus", "Julien"],
        ["Ivan", "Andrew"],
        ["Chuka", "Mateja"],
        ["Eleni", "Edward"]
      ],
      [
        ["Sam", "Rebecca"],
        ["Chuka", "Mari-Ann"],
        ["Rob", "George"],
        ["Ivan", "Hamza"],
        ["Radu", "Mahmudh"],
        ["Fergus", "Dovile"],
        ["Rajeev", "Mateja"],
        ["Octavian", "Alaan"],
        ["Mattia", "Deon"],
        ["Edward", "Julien"],
        ["Eleni", "Raphael"],
        ["Aaron", "Ezzy"],
        ["Amy", "Andrew"]
      ],
      [
        ["Eleni", "Alaan"],
        ["Chuka", "Julien"],
        ["Aaron", "Mahmudh"],
        ["Octavian", "Dovile"],
        ["Radu", "Deon"],
        ["Hamza", "Mateja"],
        ["Sam", "Raphael"],
        ["Amy", "Edward"],
        ["Ivan", "George"],
        ["Mari-Ann", "Andrew"],
        ["Rajeev", "Ezzy"],
        ["Rob", "Fergus"],
        ["Mattia", "Rebecca"]
      ],
      [
        ["Sam", "Mateja"],
        ["George", "Mahmudh"],
        ["Radu", "Julien"],
        ["Eleni", "Andrew"],
        ["Octavian", "Rebecca"],
        ["Hamza", "Alaan"],
        ["Amy", "Mattia"],
        ["Chuka", "Raphael"],
        ["Edward", "Ezzy"],
        ["Aaron", "Rajeev"],
        ["Mari-Ann", "Fergus"],
        ["Ivan", "Dovile"],
        ["Rob", "Deon"]
      ],
      [
        ["Eleni", "Deon"],
        ["Mattia", "Andrew"],
        ["Fergus", "Ezzy"],
        ["Aaron", "Alaan"],
        ["Amy", "Hamza"],
        ["Ivan", "Rebecca"],
        ["George", "Raphael"],
        ["Mari-Ann", "Julien"],
        ["Rob", "Sam"],
        ["Octavian", "Mahmudh"],
        ["Radu", "Mateja"],
        ["Edward", "Dovile"],
        ["Chuka", "Rajeev"]
      ],
      [
        ["George", "Deon"],
        ["Octavian", "Fergus"],
        ["Ivan", "Rajeev"],
        ["Aaron", "Andrew"],
        ["Eleni", "Ezzy"],
        ["Chuka", "Rebecca"],
        ["Edward", "Sam"],
        ["Amy", "Radu"],
        ["Mari-Ann", "Alaan"],
        ["Mateja", "Dovile"],
        ["Mattia", "Raphael"],
        ["Hamza", "Julien"],
        ["Rob", "Mahmudh"]
      ],
      [
        ["Amy", "Dovile"],
        ["Rob", "Radu"],
        ["Chuka", "Alaan"],
        ["Rajeev", "Deon"],
        ["Ivan", "Mari-Ann"],
        ["Sam", "Mahmudh"],
        ["Mattia", "George"],
        ["Octavian", "Aaron"],
        ["Eleni", "Julien"],
        ["Edward", "Raphael"],
        ["Mateja", "Ezzy"],
        ["Hamza", "Rebecca"],
        ["Fergus", "Andrew"]
      ],
      [
        ["Aaron", "Mateja"],
        ["Rajeev", "Rebecca"],
        ["Julien", "Dovile"],
        ["Fergus", "Raphael"],
        ["Eleni", "Mahmudh"],
        ["Ivan", "Mattia"],
        ["Octavian", "Deon"],
        ["Edward", "George"],
        ["Radu", "Ezzy"],
        ["Sam", "Alaan"],
        ["Amy", "Mari-Ann"],
        ["Rob", "Andrew"],
        ["Chuka", "Hamza"]
      ],
      [
        ["Octavian", "Ezzy"],
        ["George", "Mateja"],
        ["Rob", "Rebecca"],
        ["Mari-Ann", "Raphael"],
        ["Fergus", "Mahmudh"],
        ["Amy", "Chuka"],
        ["Radu", "Alaan"],
        ["Aaron", "Edward"],
        ["Andrew", "Deon"],
        ["Rajeev", "Hamza"],
        ["Eleni", "Sam"],
        ["Mattia", "Dovile"],
        ["Ivan", "Julien"]
      ],
      [
        ["Amy", "Mateja"],
        ["Octavian", "Mattia"],
        ["Rajeev", "Fergus"],
        ["Rob", "Julien"],
        ["Mahmudh", "Ezzy"],
        ["George", "Alaan"],
        ["Mari-Ann", "Deon"],
        ["Radu", "Edward"],
        ["Aaron", "Dovile"],
        ["Eleni", "Rebecca"],
        ["Hamza", "Andrew"],
        ["Chuka", "Sam"],
        ["Ivan", "Raphael"]
      ]
    ]
  end
end
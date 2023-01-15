RSpec.shared_context 'tmdp communicator search mock' do

	let(:mocked_answer) { YAML.load_file(File.join(Rails.root, 'spec', 'support', 'yml', 'respons.yml')) }
	before(:each)       { allow_any_instance_of(TmdbCommunicator::Search).to receive(:movie).and_return(mocked_answer) }
	after(:each)        { Rails.cache.clear }

end
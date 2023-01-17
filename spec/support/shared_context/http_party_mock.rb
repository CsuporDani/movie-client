RSpec.shared_context 'http party mock' do
  let(:mocked_answer)        { YAML.load_file(File.join(Rails.root, 'spec', 'support', 'yml', 'respons.yml')) }
  let(:http_request_object)  { HTTParty::Request.new Net::HTTP::Get, '/' }
  let(:htpp_response_object) { Net::HTTPOK.new('1.1', 200, 'OK') }
  let(:http_parsed_response) { lambda { mocked_answer } }
  let(:htpp_respons)         { HTTParty::Response.new(http_request_object, htpp_response_object, http_parsed_response, body: mocked_answer ) }
  before(:each)              { allow(HTTParty).to receive(:get).and_return(htpp_respons) }
	after(:each)               { Rails.cache.clear }
end
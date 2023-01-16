require 'rails_helper'

RSpec.describe TmdbCommunicator do
  subject { described_class.instance }
  include_context 'http party mock'

  describe 'INSTANCE METHODS' do
    context "#get" do
      let(:arg) { 'test' }
      
      it 'calls HTTParty.get with given argument' do
        expect(HTTParty).to receive(:get).with(arg)
        subject.get(arg)
      end
    end
  end
end
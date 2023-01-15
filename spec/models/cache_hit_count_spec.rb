require 'rails_helper'

RSpec.describe CacheHitCount, type: :model do
  subject { described_class.create(name: 'Test') }

  describe 'DB COLUMNS', :shoulda do
    it { should have_db_column(:name)     .of_type(:string) .with_options(null: false)             }
    it { should have_db_column(:page)     .of_type(:integer).with_options(null: false, default: 1) }
    it { should have_db_column(:hit_count).of_type(:integer).with_options(null: false, default: 0) }
  end

  describe 'VALIDATIONS', :shoulda do
    it { should validate_presence_of(:name) }
  end
end

require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject { described_class.create(title: 'Test', tmdb_id: 1) }

  describe 'DB COLUMNS', :shoulda do
    it { should have_db_column(:title)      .of_type(:string) .with_options(null: false) }
    it { should have_db_column(:tmdb_id)    .of_type(:integer).with_options(null: false) }
    it { should have_db_column(:overview)   .of_type(:string)                            }
    it { should have_db_column(:poster_path).of_type(:string)                            }
  end

  describe 'VALIDATIONS', :shoulda do
    it { should validate_presence_of(:title)     }
    it { should validate_presence_of(:tmdb_id)   }
    it { should validate_uniqueness_of(:tmdb_id) }
  end
end

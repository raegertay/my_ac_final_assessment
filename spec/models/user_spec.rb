require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:followings).with_foreign_key(:follower_id).dependent(:destroy) }
  it { is_expected.to have_many(:followees).through(:followings) }
  it { is_expected.to have_many(:inverse_followings).class_name('Following').with_foreign_key(:followee_id).dependent(:destroy) }
  it { is_expected.to have_many(:followers).through(:inverse_followings) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }

end

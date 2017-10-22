require 'spec_helper'
require 'rails_helper'

describe User do

  let(:user) { create(:user) }

  it 'should be created with valid parameters' do
    expect(user).not_to be_nil
  end

  it 'should has a password_digest attribute' do
    expect(user).to respond_to(:password_digest)
  end

end

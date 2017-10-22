require 'spec_helper'
require 'rails_helper'

describe Image do

  it 'should be created with valid parameters' do
    expect(create(:image)).to respond_to(:picture, :user_id)
  end

end

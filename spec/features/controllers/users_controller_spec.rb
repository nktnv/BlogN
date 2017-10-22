require 'spec_helper'
require 'rails_helper'

describe UsersController do

  describe 'API', type: :request do

    it 'sign up should open successfully' do
      get_new_user
      expect(response.status).to eq 200
    end

    it 'should have the form for the new user creation' do
      get_new_user
      expect(response.body).to have_selector('#new_user')
    end

    it 'log in should open successfully' do
      get_log_in
      expect(response.status).to eq 200
    end

    it 'should have the form for the user log in' do
      get_log_in
      expect(response.body).to have_selector('form[class*="session"]')
    end

  end

end

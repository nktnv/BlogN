require 'spec_helper'
require 'rails_helper'

describe PostsController do

  before(:all) do
    @body = Faker::Lorem.paragraph
    @summary = Faker::Lorem.sentence
    create(:post, body: @body, summary: @summary)
  end

  describe 'API', type: :request do

    it 'all posts page should open successfully' do
      get_root_path
      expect(response.status).to eq 200
    end

    it 'should display posts on root page' do
      get_root_path
      expect(response.body).to have_css('div.post')
    end

    it 'should display posts summary on root page' do
      get_root_path
      expect(response.body).to have_content(@summary)
    end

    it 'should not display posts body' do
      get_root_path
      expect(response.body).not_to have_content(@body)
    end

    it 'should open posts details successfully' do
      get_to_post(post_id_by_body(@body))
      expect(response.status).to eq 200
    end

    it 'should posts body on posts details page' do
      get_to_post(post_id_by_body(@body))
      expect(response.body).to have_content(@body)
    end

    it 'should not display posts summary on posts details page' do
      get_to_post(post_id_by_body(@body))
      expect(response.body).not_to have_content(@summary)
    end

  end

end

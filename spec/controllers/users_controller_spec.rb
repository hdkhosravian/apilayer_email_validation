require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      create_list(:user, 3)
      get :index, params: {}

      expect(response).to be_successful
      expect(assigns['users'].count).to be(3)
    end

    it "search a valid user" do
      mock_requests

      create_list(:user, 3)

      params = FactoryBot.attributes_for(:user, first_name: 'ben', last_name: 'pratt', url: '8returns.com')
      get :index, params: params

      expect(response).to be_successful
      expect(assigns['users'].count).to be(4)
      expect(assigns['users'].last.url).to eq(params[:url])
    end

    it "invalid url" do
      create_list(:user, 3)

      params = FactoryBot.attributes_for(:user, first_name: 'ben', last_name: 'pratt', url: '8returns')
      get :index, params: params

      expect(response).to be_successful
      expect(assigns['users'].count).to be(3)
      expect(assigns['errors']).to include('invalid url')
    end
  end
end

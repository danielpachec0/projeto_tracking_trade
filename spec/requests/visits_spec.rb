require 'rails_helper'

RSpec.describe "Visits", type: :request do
  describe 'GET /visits' do
    before do
      create(:visit)
      create(:visit, user_id: 1)
    end
    it 'return all visits' do
      get visits_url

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /visits' do
    before do
      create(:user)
    end
    it 'Creates a new visit' do
      
      expect {
        post visits_url, params: { visit: { date: DateTime.current, status: 'status', user_id: 1, checkin_at: DateTime.yesterday,  checkout_at:  DateTime.tomorrow.tomorrow} }
      }.to change(Visit, :count).from(0).to(1)


      expect(response).to have_http_status(:created)
    end
    it 'does not create a valid visit' do
      expect {
        #passes an invalid user id
        post visits_url, params: { visit: { date: DateTime.current, status: 'status', user_id: 2, checkin_at: DateTime.yesterday,  checkout_at:  DateTime.tomorrow.tomorrow} }
      }.to_not change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end 
  end
  describe 'PATCH /visit/:id' do
    let!(:visit) { create(:visit) } 

    it 'updates a visit' do
      expect {
        patch visit_url(visit.id), params: { visit: { status: 'new status' } }  
      }.to_not change(User, :count)

      expect(response).to have_http_status(:ok)
    end  
  end
end

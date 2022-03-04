require 'rails_helper'


RSpec.describe "Answers api", type: :request do
  describe 'GET /answers' do
    before do
      form = create(:formulary)
      question = create(:question, formulary: form)
      create(:answer, question: question, formulary: form)
      create(:answer, question: question, formulary: form)
    end
    it 'return all answers' do
      get answers_url
      
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'GET /answers/:id' do

    let!(:answer) { create(:answer, formulary: create(:formulary), question: create(:question, formulary_id: 1)) } 
    it 'return the specified formulary' do
      get formulary_url(answer.id)
      
      expect(response).to have_http_status(:success)
    end
  end 

  describe 'POST /answers' do
    before do
      create(:formulary)
      create(:question, formulary_id: 1)
    end
    it 'create a new question' do
      expect {
        post answers_url, params: { answer: { content: 'qustion content', formulary_id: 1, question_id: '1' } }
      }.to change(Answer, :count).from(0).to(1)
      

      expect(response).to have_http_status(:created)
      
    end
  end

  describe 'PATCH /answers/:id' do
    let!(:answer) { create(:answer, formulary: create(:formulary), question: create(:question, formulary_id: 1)) } 
 

    it 'updates a answer' do
      expect {
        patch answer_url(answer.id), params: { answer: { content: 'new content' } }  
      }.to_not change(Answer, :count)

      expect(response).to have_http_status(:ok)
    end  
  end

  describe 'DELETE /answers/:id' do
    let!(:answer) { create(:answer, formulary: create(:formulary), question: create(:question, formulary_id: 1)) } 

    it 'deletes a answer' do
      expect {
        delete answer_url(answer.id) 
      }.to change(Answer, :count).from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end 
end

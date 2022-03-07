class Answer < ApplicationRecord
    acts_as_paranoid


    validates :formulary_id, :question_id, presence: true
    
    belongs_to :question
    belongs_to :formulary
    has_one :visit
end

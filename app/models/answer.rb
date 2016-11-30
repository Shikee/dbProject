class Answer < ApplicationRecord
    belongs_to :question
    belongs_to :user
    ratyrate_rateable 'coolness'
end

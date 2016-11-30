class Question < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :answers , dependent: :destroy
    has_many :hevals , dependent: :destroy

    ratyrate_rateable 'coolness'
end

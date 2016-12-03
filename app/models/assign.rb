class Assign < ApplicationRecord
  belongs_to :question
  belongs_to :user
  belongs_to :mentorgroup
end

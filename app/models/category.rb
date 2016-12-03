class Category < ApplicationRecord
    validates :name, :presence => true, :uniqueness => true

    has_many :questions, dependent: :restrict_with_error
    has_many :mentorgroups ,dependent: :destroy
end

class Mentorgroup < ApplicationRecord
  validates :name, :presence => true, :uniqueness => true
  belongs_to :category
  belongs_to :user
  has_many :WorksFor
  has_many :assigns
  has_many :users, :through => :WorksFor
end

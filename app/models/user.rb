class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :sex, :nickname ,:message => "정보를 적어주세요!"
  has_many :mentorgroups
  has_many :WorksFor
  has_many :mentorgroups, :through => :WorksFor
  has_many :answers
  has_many :questions
  has_many :hevals 

  ratyrate_rater #rate
end
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :nickname , uniqueness: true
  validates_presence_of :name, :sex,:birth, :nickname ,:message => "정보를 적어주세요!"

  has_many :mentorgroups
  has_many :WorksFor ,dependent: :destroy
  has_many :mentorgroups, :through => :WorksFor
  has_many :answers
  has_many :questions
  has_many :hevals
  has_many :qevals,dependent: :destroy
  has_many :aevals,dependent: :destroy
  has_many :assigns ,dependent: :destroy
end

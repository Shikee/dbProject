class Question < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :answers , dependent: :destroy
    has_many :hevals , dependent: :destroy
    has_many :qevals , dependent: :destroy
    has_many :assigns,dependent: :destroy
    def qpoint
      self.qevals.average("ratepoint").to_i
    end
    def category_name
      self.category.name.to_s
    end
    def caneval
      (self.created_at + $due) > Time.now
    end


    def self.sorted_by_qpoint
      Question.all.sort_by(&:qpoint).reverse
    end
    def self.sorted_by_category_name
      Question.all.sort_by(&:category_name).reverse
    end
    def self.sorted_by_caneval
      Question.all.sort_by(&:caneval).reverse

    end

end

class Question < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :answers , dependent: :destroy
    has_many :hevals , dependent: :destroy
    has_many :qevals , dependent: :destroy
    has_many :assigns,dependent: :destroy

    def qpoint1
      self.qevals.average("ratepoint").to_i
    end
    
    def qpoint2
      self.qevals.average("ratepoint").to_i
    end

    def category_name
      self.category.name.to_s
    end
    def caneval
      if (self.created_at + $due) > Time.now
        return 1
      else
        return 0
      end
    end
    def self.sorted_by_qpoint
      Question.all.sort_by(&:qpoint1).reverse
    end
    def self.sorted_by_qpoint2
      Question.all.sort_by(&:qpoint2)
    end
    def self.sorted_by_category_name
      Question.all.sort_by(&:category_name).reverse
    end
    def self.sorted_by_caneval
      Question.all.sort_by(&:caneval).reverse
    end


end

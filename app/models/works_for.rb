class WorksFor < ApplicationRecord
    belongs_to :user ,:foreign_key => 'user_id'
    belongs_to :mentorgroup,:foreign_key => 'mentorgroup_id'
end

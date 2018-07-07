class Work < ApplicationRecord
    belongs_to :user
    #validates :note, length: { maximum: 20 }
end

class Work < ApplicationRecord
  belongs_to :user
  include FriendlyId
  friendly_id :day
end

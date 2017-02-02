class Play < ApplicationRecord
  validates :title, :description, :director, presence: true
end

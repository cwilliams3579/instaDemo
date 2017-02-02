class Play < ApplicationRecord
  belongs_to :user
  belogns_to :category
  validates :title, :description, :director, presence: true
end

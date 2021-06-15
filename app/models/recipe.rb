class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }

  belongs_to :chef
  validates :chef_id, presence: true
  # when we call recipe.all it will sort automatically by updated_at
  default_scope -> { order(updated_at: :desc) }
end

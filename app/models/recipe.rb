class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }

  belongs_to :chef
  validates :chef_id, presence: true
  # when we call recipe.all it will sort automatically by updated_at
  default_scope -> { order(updated_at: :desc) }

  has_many :recipe_ingredients
  # ingredient = Ingredient.first
  # recipe = Recipe.first
  # recipe.ingredients << ingredient => it will create new record in recipe_ingredients table.
  has_many :ingredients, through: :recipe_ingredients

  # dependent => if a recipe deleted, comments that associated with that recipe will also be deleted
  has_many :comments, dependent: :destroy
end

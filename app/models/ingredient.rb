class Ingredient < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name

  has_many :recipe_ingredients
  # ingredient = Ingredient.first
  # recipe = Recipe.first
  # ingredient.recipes << recipe => it will create new record in recipe_ingredients table.
  has_many :recipes, through: :recipe_ingredients
end

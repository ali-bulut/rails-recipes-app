require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com",
                         password: "testtest", password_confirmation: "testtest")
    @recipe = Recipe.create(name: "test recipe", description: "test desc", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef)
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some desc" } }
    assert_template 'recipes/edit'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

  test "succesfully edit a recipe" do
    sign_in_as(@chef)
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "updated recipe name"
    updated_desc = "updated desc"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_desc } }
    assert_redirected_to @recipe
    # follow_redirect!
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_desc, @recipe.description
  end
end

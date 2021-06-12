require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com")
    @recipe = Recipe.create(name: "test recipe", description: "test desc", chef: @chef)
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes list" do
    get recipes_path
    assert_template 'recipes/index'
    # that means name of the recipe should be on body of the template
    assert_match @recipe.name, response.body
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name.capitalize, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
end

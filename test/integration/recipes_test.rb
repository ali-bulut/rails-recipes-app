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
  end
end

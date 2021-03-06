require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com",
                         password: "testtest", password_confirmation: "testtest")
    @recipe = Recipe.create(name: "test recipe", description: "test desc", chef: @chef)
  end

  test "successfully delete recipe" do
    sign_in_as(@chef)
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end

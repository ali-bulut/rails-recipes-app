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
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    desc_of_recipe = "add chicken, add vegetables, cook for 20 minutes"
    assert_difference "Recipe.count", 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: desc_of_recipe } }
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match desc_of_recipe, response.body
  end

  test "reject invalid recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference "Recipe.count" do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end

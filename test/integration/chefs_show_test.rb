require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com",
                         password: "testtest", password_confirmation: "testtest")
    @recipe = Recipe.create(name: "test recipe", description: "test desc", chef: @chef)
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end
end

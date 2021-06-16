require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com",
                         password: "testtest", password_confirmation: "testtest")
    @admin_user = Chef.create!(chefname: "test chef2", email: "test2@test2.com",
                               password: "testtest", password_confirmation: "testtest", admin: true)
  end

  test "should get chefs listing" do
    get chefs_path
    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@admin_user)
    get chefs_path
    assert_template "chefs/index"
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end

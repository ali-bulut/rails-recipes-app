require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "test chef", email: "test@test.com",
                         password: "testtest", password_confirmation: "testtest")
  end

  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: { chef: { chefname: " ", email: "test@test.com" } }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: { chef: { chefname: "new name", email: "newtest@test.com" } }
    assert_redirected_to @chef # short form for the chef show page
    assert_not flash.empty?
    @chef.reload
    assert_match "new name", @chef.chefname
    assert_match "newtest@test.com", @chef.email
  end

end

require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: 'ali', email: 'ali@mail.com',
                     password: "testtest", password_confirmation: "testtest")
  end

  test 'chef should be valid' do
    assert @chef.valid?
  end

  test 'chefname should be present' do
    @chef.chefname = ' '
    assert_not @chef.valid?
  end

  test 'name should be less than 30 characters' do
    @chef.chefname = 'a' * 31
    assert_not @chef.valid?
  end

  test 'email should be present' do
    @chef.email = ' '
    assert_not @chef.valid?
  end

  test 'email should not be too long' do
    @chef.email = 'a' * 255 + '@example.com'
    assert_not @chef.valid?
  end

  test 'email should accept correct format' do
    valid_emails = %w[user@example.com ALI@gmail.com M.first@yahoo.com john+smith@co.uk.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test 'should reject invalid email addresses' do
    invalid_emails = %w[test@test test@test,com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert @chef.invalid?, "#{invalids.inspect} should be invalid"
    end
  end

  test 'email should be unique and case insensitive' do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test 'email should be lower case before hitting db' do
    mixed_email = "ALi@MaIl.cOm"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "test"
    assert_not @chef.valid?
  end

  test "associated recipes should be removed" do
    @chef.save
    @chef.recipes.create!(name: "testing", description: "testing")
    assert_difference "Recipe.count", -1 do
      @chef.destroy
    end
  end
end

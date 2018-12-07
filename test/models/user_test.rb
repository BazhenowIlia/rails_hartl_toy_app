require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: 'Ilia Bazhenow', 
                     email: 'iliagamer@gmail.com', 
                     password: 'foobar', 
                     password_confirmation: 'foobar')
  end
  
  test 'should validate user' do
    assert @user.valid?
  end
  
  # Presense validation
  
  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end
  
  test 'email should be present' do
    @user.email = ""
    assert_not @user.valid?
  end
  
  # Max length validation
  
  test 'username should not be to long' do
    @user.name = 'a' * 52
    assert_not @user.valid?
  end
  
  test 'email should not be to long' do
    @user.email = 'a' * 248 + '@gmail.com'
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                       first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |email|
      @user.email = email
      assert @user.valid? "#{email.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]
  invalid_addresses.each do |invalid_address|
    @user.email = invalid_address
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test 'email adresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'email adresses should be saved as lowercase' do
     mixed_case_email = "Foo@ExAMPle.CoM"
     @user.email = mixed_case_email
     @user.save
     assert_equal mixed_case_email.downcase, @user.reload.email
   end
   
  test 'password should be not blank' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
 
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'b' * 5
    assert_not @user.valid?        
  end
end

require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test 'should not create empty user' do
    # assert_select 'form[action=?]', '/signup' Doest work
    assert_no_difference 'User.count' do
      post signup_path, params: { user: {
                                  name: 'Ilia Bazhenow',
                                  email: '    ',
                                  password: 'foobar',
                                  password_confirmation: 'foobar' }}
      end
      assert_template 'users/new'
      assert_select '#error_explanation', 1
      assert_select '.field_with_errors', 2
  end
  
  test 'should create new user' do
    get signup_path
    assert_difference 'User.count', 1 do 
      post signup_path, params: { user: {
                                    name: 'Example user',
                                    email: 'example@rails.com',
                                    password: 'foobar',
                                    password_confirmation: 'foobar' }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end

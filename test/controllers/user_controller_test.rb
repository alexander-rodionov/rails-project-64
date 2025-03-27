# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  # Форма регистрации
  test 'should show register form ok' do
    get new_user_registration_path # new sesssion
    assert_response :success
    assert_match 'Регистрация', response.body
    assert_match 'Эл. почта', response.body
    assert_match 'Эл. почта', response.body
    assert_match 'Пароль', response.body
    assert_match '(минимум символов: 6)', response.body
    assert_match 'Подтверждение пароля', response.body
    assert_match(/input.*submit.*Регистрация/, response.body)
  end

  # Отправка формы регистрации - happy path
  test 'should register form process ok' do
    assert_difference 'User.count' do
      post user_registration_path, params: { user: {
        email: 'zzz@zz.zz',
        password: '123456',
        password_confirmation: '123456'
      } }
    end
    assert_response :redirect
    follow_redirect!
    assert_match 'zzz@zz.zz', response.body
  end

  test 'should register form process fail 1' do
    post user_registration_path, params: { user: {
      email: 'zzzzzzz',
      password: '123456',
      password_confirmation: '123456'
    } }
    assert_response :unprocessable_content
  end

  test 'should register form process fail 2' do
    post user_registration_path, params: { user: {
      email: 'zzz@zz.zz',
      password: '123456',
      password_confirmation: '654321'
    } }
    assert_response :unprocessable_content
  end

  test 'should register form process fail 3' do
    post user_registration_path, params: { user: {
      email: 'zzz@zz.zz',
      password: '123',
      password_confirmation: '123'
    } }
    assert_response :unprocessable_content
  end

  # Форма логина
  test 'should show sign in form' do
    get user_session_path
    assert_response :success
    assert_match 'Войти', response.body
    assert_match 'Эл. почта', response.body
    assert_match 'Пароль', response.body
    assert_match 'Запомнить меня', response.body
    assert_match 'Регистрация', response.body
    assert_match 'Забыли пароль', response.body
  end

  # Отправка формы логина
  test 'should sign in' do
    current_user = users(:user_one)
    post user_session_path, params: { user: {
      email: current_user.email.to_s,
      password: 'aaaaaa',
      remember_me: false
    } }
    assert_response :redirect
    follow_redirect!
    assert_match 'href="/users/sign_out">Выйти', response.body
  end

  test 'should sign_out' do
    current_user = users(:user_one)
    sign_in(current_user)
    get destroy_user_session_path
    assert_response :redirect
    follow_redirect!
    assert_match 'href="/users/sign_in">Войти', response.body
  end
end

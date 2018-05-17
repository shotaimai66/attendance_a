require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Progra:情報シェア"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Progra:情報シェア"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Progra:情報シェア"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Progra:情報シェア"
  end
end
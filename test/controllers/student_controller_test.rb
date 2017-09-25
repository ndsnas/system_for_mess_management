require 'test_helper'

class StudentControllerTest < ActionDispatch::IntegrationTest
  test "should get view_menu" do
    get student_view_menu_url
    assert_response :success
  end

  test "should get view_bill" do
    get student_view_bill_url
    assert_response :success
  end

  test "should get apply_mess" do
    get student_apply_mess_url
    assert_response :success
  end

  test "should get pay_bill" do
    get student_pay_bill_url
    assert_response :success
  end

  test "should get purchase_history" do
    get student_purchase_history_url
    assert_response :success
  end

  test "should get change_password" do
    get student_change_password_url
    assert_response :success
  end

  test "should get feedback" do
    get student_feedback_url
    assert_response :success
  end

end

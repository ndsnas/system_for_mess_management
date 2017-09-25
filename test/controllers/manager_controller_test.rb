require 'test_helper'

class ManagerControllerTest < ActionDispatch::IntegrationTest
  test "should get add_student" do
    get manager_add_student_url
    assert_response :success
  end

  test "should get delete_student" do
    get manager_delete_student_url
    assert_response :success
  end

  test "should get view_menu" do
    get manager_view_menu_url
    assert_response :success
  end

  test "should get update_menu" do
    get manager_update_menu_url
    assert_response :success
  end

  test "should get add_mess_cut" do
    get manager_add_mess_cut_url
    assert_response :success
  end

  test "should get update_mess_cut" do
    get manager_update_mess_cut_url
    assert_response :success
  end

  test "should get per_month_fee_detail" do
    get manager_per_month_fee_detail_url
    assert_response :success
  end

  test "should get extra_per_day" do
    get manager_extra_per_day_url
    assert_response :success
  end

  test "should get backup_db" do
    get manager_backup_db_url
    assert_response :success
  end

  test "should get view_stock" do
    get manager_view_stock_url
    assert_response :success
  end

  test "should get update_stock" do
    get manager_update_stock_url
    assert_response :success
  end

  test "should get monthly_profit_analysis" do
    get manager_monthly_profit_analysis_url
    assert_response :success
  end

  test "should get view_feedback" do
    get manager_view_feedback_url
    assert_response :success
  end

end

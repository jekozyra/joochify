require 'test_helper'

class ParolasControllerTest < ActionController::TestCase
  setup do
    @parola = parolas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parolas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parola" do
    assert_difference('Parola.count') do
      post :create, parola: { input: @parola.input, output: @parola.output }
    end

    assert_redirected_to parola_path(assigns(:parola))
  end

  test "should show parola" do
    get :show, id: @parola
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parola
    assert_response :success
  end

  test "should update parola" do
    patch :update, id: @parola, parola: { input: @parola.input, output: @parola.output }
    assert_redirected_to parola_path(assigns(:parola))
  end

  test "should destroy parola" do
    assert_difference('Parola.count', -1) do
      delete :destroy, id: @parola
    end

    assert_redirected_to parolas_path
  end
end

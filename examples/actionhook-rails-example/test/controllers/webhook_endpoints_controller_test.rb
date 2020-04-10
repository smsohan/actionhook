require 'test_helper'

class WebhookEndpointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @webhook_endpoint = webhook_endpoints(:one)
  end

  test "should get index" do
    get webhook_endpoints_url
    assert_response :success
  end

  test "should get new" do
    get new_webhook_endpoint_url
    assert_response :success
  end

  test "should create webhook_endpoint" do
    assert_difference('WebhookEndpoint.count') do
      post webhook_endpoints_url, params: { webhook_endpoint: { auth_token: @webhook_endpoint.auth_token, auth_type: @webhook_endpoint.auth_type, secret: @webhook_endpoint.secret, url: @webhook_endpoint.url } }
    end

    assert_redirected_to webhook_endpoint_url(WebhookEndpoint.last)
  end

  test "should show webhook_endpoint" do
    get webhook_endpoint_url(@webhook_endpoint)
    assert_response :success
  end

  test "should get edit" do
    get edit_webhook_endpoint_url(@webhook_endpoint)
    assert_response :success
  end

  test "should update webhook_endpoint" do
    patch webhook_endpoint_url(@webhook_endpoint), params: { webhook_endpoint: { auth_token: @webhook_endpoint.auth_token, auth_type: @webhook_endpoint.auth_type, secret: @webhook_endpoint.secret, url: @webhook_endpoint.url } }
    assert_redirected_to webhook_endpoint_url(@webhook_endpoint)
  end

  test "should destroy webhook_endpoint" do
    assert_difference('WebhookEndpoint.count', -1) do
      delete webhook_endpoint_url(@webhook_endpoint)
    end

    assert_redirected_to webhook_endpoints_url
  end
end

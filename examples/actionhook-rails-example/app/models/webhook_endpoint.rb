class WebhookEndpoint < ApplicationRecord
  def authentication
    if auth_type == 'Token'
      ActionHook::Security::Authentication::Token.new(auth_token)
    else
      ActionHook::Security::Authentication::BearerToken.new(auth_token)
    end
  end
end

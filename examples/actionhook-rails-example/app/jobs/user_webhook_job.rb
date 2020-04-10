class UserWebhookJob < ApplicationJob

  def perform(webhook_endpoint, user, change_type)
    payload = {
      user: {
        id: user.id,
        name: user.name
      },
      change_type: change_type
    }

    request = ActionHook::Core::JSONRequest.new(
      url: webhook_endpoint.url,
      body: payload,
      secret: webhook_endpoint.secret
    )

    ActionHook::Core::NetHTTPSender.send(request)
  end


end
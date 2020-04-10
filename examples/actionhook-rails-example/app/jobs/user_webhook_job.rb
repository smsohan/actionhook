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
      body: payload
    )

    ActionHook::Core::NetHTTPSender.send(request)
  end


end
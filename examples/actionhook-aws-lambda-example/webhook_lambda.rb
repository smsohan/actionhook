$LOAD_PATH.unshift 'vendor/bundle/ruby/2.5.0/bundler/gems/actionhook-a9b283313471/lib'

require 'actionhook'

# EXAMPLE EVENT

# event = {
#   "url": "<YOUR WEBHOOK RECEIVER URL>",
#   "body": {
#     "user": {"id": 10, "name": "Gaga Gigi"},
#     "change_type": "created"
#   },
#   "secret": "YOUR SECRET FOR SHA256 SIGNING",
#   "auth_token": "YOUR Token Authorization value"
# }


def lambda_handler(event:, context:)

  request = ActionHook::Core::JSONRequest.new(
    url: event['url'],
    body: event['body'],
    secret: event['secret'],
    authentication: ActionHook::Security::Authentication::Token.new(event['auth_token'])
  )
  ActionHook::Core::NetHTTPSender.send(request)

end
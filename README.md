# Why?

A drop-in library for sending webhooks. You specify the content and
destination, ActionHook takes care of securely delivering it following industry
best-practices.


## Build Status

![Build](https://github.com/smsohan/actionhook/workflows/Ruby/badge.svg)

# Features:

- [x] **Core** Send webhooks
- [x] **Configuration** Timeout
- [x] **Security** Auth Token
- [x] **Security** Blocked IP ranges
- [x] **Security** Hashing with secure key
- [ ] **More** Logging
- [ ] **More** Instrumentation
- [x] **Scale** Trigger using AWS Lambda
- [x] **Usability** Example Ruby on Rails app.


## Send Webhooks

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
```

## Configuration

All configurations are optional, only use these if you want to override the defaults.
You can set the following configs in `ActionHook.configuration` object.

|Name|Description|Default Value|
|---|---|---|
|`open_timeout` | `Net::HTTP` open timeout in seconds | `5` |
|`read_timeout` | `Net::HTTP` read timeout in seconds | `15`|
|`hash_header_name` | A HTTP Request header that contains the SHA256 fingerprint of the request body | `SHA256-FINGERPRINT` |
|`allow_private_ips` | If loopback or private IPs should be allowed as receiver | `false` |
|`blocked_ip_ranges` | Custom IP ranges to block, e.g. `%w{172.8.9.8/24}`| `[]`|

Instead of the global config using ActionHook.configuration, you can provide an instance of `ActionHook::Core::Configuration` to the `send` method. Please note that, global config will be ignored when you provide a configuration while calling `send`. Here's an example of providing a configuration while calling `send`.

```ruby
ActionHook::Core::NetHttpSender.send(request, ActionHook::Core::Configuration.new)
```

## Authentication

ActionHook supports `Basic`, `Token`, and `BearerToken` authentication out of the box. You can assign one of these authentication methods to the request object as follows:

```ruby
  basic = ActionHook::Security::Authentication::Basic.new('a_user', 'a_pass')
  token = ActionHook::Security::Authentication::Token.new('a_token')
  bearer_token = ActionHook::Security::Authentication::BearerToken.new('a_bearer_token')

  request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
    authentication: basic, # or token, bearer_token
  )
```

## Hashing With a Secure Key: 2-Factor Authentication

You can generate secure key for each receiving endpoint and pass it to `ActionHook`
for adding a 2-factor authentication. Using this this key, `ActionHook` will automatically add the `SHA256-FINGERPRINT` header to the webhook. The receiver can compute the SHA256 digest of the request body using the same secret to verify the sender and message integrity.

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  secret: '<Your Secret For This Hook>', # Remember to provide your secret
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
```

## IP Blocking

When a request is blocked due to private IP, `send` raises `ActionHook::Security::IPBlocking::PrivateIPError`.
When a request is blocked due to the blocked_ip_ranges, `send` raises `ActionHook::Security::IPBlocking::BlockedRequestError`.
In both cases, the error message includes necessary context for debugging / logging.

## Examples

Please check [examples/actionhook-rails-example](examples/actionhook-rails-example) to see a demo Ruby on Rails app using ActionHook over ActiveJob.

Please check [examples/actionhook-aws-lambda-example](examples/actionhook-aws-lambda-example) to see a demo AWS lambda function using ActionHook.
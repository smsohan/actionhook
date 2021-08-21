# Why?

`ActionHook` is a drop-in ruby gem for sending webhooks. You specify the content and destination, `ActionHook` takes care of securely delivering it.

Sending a webhook from an application starts out as a simple coding task. To put webhooks into production is actually quite complex because you need to worry about timeouts, retry, TLS issues, authentication, and secure delivery. Scaling webhooks can be a challenge if you have to send thousands of such hooks every second. This library is designed with these features in mind and should work for most use cases.

## Build Status
[![Ruby](https://github.com/smsohan/actionhook/actions/workflows/ruby.yml/badge.svg)](https://github.com/smsohan/actionhook/actions/workflows/ruby.yml)

# Features

- [x] **Core** Send webhooks
- [x] **Configuration** Timeout, IP blocking, etc.
- [x] **Security** Supports HTTP Basic, Token, and Bearer Token auth
- [x] **Security** Blocks private IPs and allows custom IP blocking
- [x] **Security** 2-factor authentication using a secret for each receiver
- [x] **Usability** Works seamlessly on Ruby on Rails. [Example](examples/actionhook-rails-example)
- [x] **Scale** Works seamlessly on AWS Lambda. [Example](examples/actionhook-aws-lambda-example)
- [x] **More** Logging

## Send Webhooks

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHTTPSender.send(request)
```

## Configuration

All configs are optional, only use these if you want to override the defaults.
You can set the following configs in `ActionHook.configuration` object.

|Name|Description|Default Value|
|---|---|---|
|`open_timeout` | `Net::HTTP` open timeout in seconds | `5` |
|`read_timeout` | `Net::HTTP` read timeout in seconds | `15`|
|`hash_header_name` | A HTTP Request header that contains the SHA256 fingerprint of the request body | `SHA256-FINGERPRINT` |
|`allow_private_ips` | If loopback or private IPs should be allowed as receiver | `false` |
|`blocked_ip_ranges` | Custom IP ranges to block, e.g. `%w{172.8.9.8/24}`| `[]`|

Instead of `ActionHook.configuration`, you can provide an instance of `ActionHook::Core::Configuration` to the `send` method as follows:

```ruby
ActionHook::Core::NetHTTPSender.send(request, ActionHook::Core::Configuration.new)
```

## Security: Authentication

ActionHook supports `Basic`, `Token`, and `BearerToken` authentication out of the box. You can assign one of these authentication methods to the request object as follows:

```ruby
  basic = ActionHook::Security::Authentication::Basic.new(username: 'a_user', password: 'a_pass')
  token = ActionHook::Security::Authentication::Token.new('a_token')
  bearer_token = ActionHook::Security::Authentication::BearerToken.new('a_bearer_token')

  request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
    authentication: basic, # or token, bearer_token
  )
```

## Security: 2-Factor Authentication: Hashing With a Secure Key

You can generate a secure key for each receiving endpoint and pass it to `ActionHook`
for adding a 2<sup>nd</sup> factor authentication. Using this key, `ActionHook` will automatically add the `SHA256-FINGERPRINT` header to the webhook. The receiver can compute the SHA256 digest of the request body using the same secret to verify you as the sender and message integrity.

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  secret: '<Your Secret For This Hook>', # Remember to provide your secret
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHTTPSender.send(request)
```

## Security: IP Blocking

When a request is blocked due to private IP receiver, `send` raises `ActionHook::Security::IPBlocking::PrivateIPError`.

When a request is blocked due to the `blocked_ip_ranges`, `send` raises `ActionHook::Security::IPBlocking::BlockedRequestError`.

In both cases, the error message includes necessary context for debugging / logging.

## Logging

You should pass an instance of `Logger` to put all `ActionHook` logs into where your application log is. Otherwise, logs are written into `STDOUT` by default.

```ruby
# For example, in Rails, you can pass the Rails logger in an initializer
# config/initializers/actionhook_initializer.rb

ActionHook.logger = Rails.logger
```

Set the log level to `debug` for detailed information. Even in debug, the secure header values aren't logged for accidental credential leakage, only the header names are mentioned.

## Develop and Contribute

```bash
# Install dependencies
$ bundle

# Run tests
$ bundle exec rspec
```

Make your changes on a fork and send a pull-request when you're ready. Include details about the intent and how you tested your changes.

Works great on GitHub Codespaces, too.
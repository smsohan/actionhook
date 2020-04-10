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
- [ ] **Security** Blocked IP ranges
- [x] **Security** Hashing with secure key
- [ ] **More** Logging
- [ ] **More** Instrumentation
- [ ] **HTTP Adapters** Allow the use of different REST clients
- [ ] **Performance** HTTP keep-alive, gzip / compress
- [ ] **Scale** Trigger using AWS Lambda, GCP, Azure functions, Docker


## Send Webhooks

```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
```

## Configuration


All configurations are optional, only use these if you want to override the defaults
```ruby
ActionHook.configuration.open_timeout = 3 # default is 5 seconds
ActionHook.configuration.read_timeout = 10 # default is 10 seconds
ActionHook.configuration.hash_header_name = 'CUSTOM-HASH-HEADER' # default is SHA256-FINGERPRINT
```

## Hashing With a Secure Key
```ruby
request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
  secret: '<Your Secret For This Hook>', # Remember to provide your secret
  method: :post, body: { hello: "world" }, headers: {})

ActionHook::Core::NetHttpSender.send(request)
# Will automatically append header named CUSTOM-HASH-HEADER with the SHA256 fingerprint of the request body.
```


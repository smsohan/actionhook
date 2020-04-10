json.extract! webhook_endpoint, :id, :url, :auth_type, :auth_token, :secret, :created_at, :updated_at
json.url webhook_endpoint_url(webhook_endpoint, format: :json)

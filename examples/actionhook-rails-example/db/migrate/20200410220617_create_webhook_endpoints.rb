class CreateWebhookEndpoints < ActiveRecord::Migration[6.0]
  def change
    create_table :webhook_endpoints do |t|
      t.string :url
      t.string :auth_type
      t.string :auth_token
      t.string :secret

      t.timestamps
    end
  end
end

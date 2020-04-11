# README

This is an example of using ActionHook within a Rails app.

First, we create a model `WebhookEndpoint` that saves the [information about endpoint](db/schema.rb) such as the URL, authentication, and a secret.

Second, we create an `ActiveJob` job called [`UserWebhookJob`](app/jobs/user_webhook_job.rb) that uses ActionHook to actually send the webhooks.

Finally, we call the job from [`UsersController`](app/controllers/users_controller.rb) to show a working example of firing webhooks within Rails.
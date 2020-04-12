# README

This is an example of using ActionHook within a Rails app.

First, we create a model `WebhookEndpoint` that saves the [information about endpoint](db/schema.rb#L21-L28) such as the URL, authentication, and a secret.

Second, we create an `ActiveJob` job called [`UserWebhookJob`](app/jobs/user_webhook_job.rb) that uses ActionHook to actually send the webhooks.

Third, we set the `ActionHook.logger` to `Rails.logger` in the [initializer](config/initializers/actionhook_init.rb)

Finally, we call the job from [`UsersController`](app/controllers/users_controller.rb#L31) to show a working example of firing webhooks within Rails.

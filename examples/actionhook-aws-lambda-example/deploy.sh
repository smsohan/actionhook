zip -r lambda.zip webhook_lambda.rb vendor

aws lambda update-function-code \
  --function-name actionhook \
  --zip-file fileb://lambda.zip \
  --region us-east-1
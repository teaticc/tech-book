# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Amazon::Ecs.debug = true
Amazon::Ecs.options = {
  associate_tag: ENV["AMAZON_ASSOCIATE_TAG"],
  AWS_access_key_id: ENV['ACCESS_KEY_ID'],
  AWS_secret_key: ENV['SECRET_ACCESS_KEY']
}

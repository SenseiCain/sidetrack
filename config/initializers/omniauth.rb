Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer
    # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end
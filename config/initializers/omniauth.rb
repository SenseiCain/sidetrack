Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    provider :google, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
  end
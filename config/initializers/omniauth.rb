OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['1788265767871902'], ENV['dcc6f58278e45625d289d42610677d2d']
end

OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "101751453943326", "5fec65349f72b2751fe5dca3ca4a6ae7"
end

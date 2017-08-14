OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Settings.google.client_id, Settings.google.sicret, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, Settings.google.client_id, Settings.google.sicret,
#            {
#                name: 'google',
#                scope: 'email, profile, plus.me, http://gdata.youtube.com',
#                prompt: 'select_account',
#                image_aspect_ratio: 'square',
#                image_size: 50
#            }
# end
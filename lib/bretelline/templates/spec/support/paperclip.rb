require 'paperclip/matchers'

RSpec.configure do |config|
  config.include Helpers
  config.include Paperclip::Shoulda::Matchers

  Paperclip::Attachment.default_options[:storage] = 'filesystem'
end

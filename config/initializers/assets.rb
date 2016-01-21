# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( works.css users.css sessions.css comments.css announcements.css abouts.css errors.css notifications.css)

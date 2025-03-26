I18n.load_path += Dir[Rails.root.join('config', 'locale', '*.{rb,yml}')]
I18n.available_locales = [ :ru, :en ]
I18n.default_locale = :ru

# frozen_string_literal: true

I18n.load_path += Rails.root.glob("config/locale/*.{rb,yml}")
I18n.available_locales = %i[ru en]
I18n.default_locale = :ru

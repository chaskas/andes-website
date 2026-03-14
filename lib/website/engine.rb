require "importmap-rails"

module Website
  class Engine < ::Rails::Engine
    isolate_namespace Website

    initializer "website.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.precompile += %w[ website_manifest ]
    end

    initializer "website.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end

    initializer "website.i18n" do
      config.i18n.load_path += Dir[root.join("config/locales/**/*.yml")]
      config.i18n.default_locale = :es
      config.i18n.available_locales = %i[es en de]
    end
  end
end

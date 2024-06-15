require "importmap-rails"

module Website
  class Engine < ::Rails::Engine
    isolate_namespace Website

    initializer "website.assets" do |app|
      app.config.assets.paths << root.join("app/javascript")
      app.config.assets.paths << root.join("app/assets/builds")
      app.config.assets.precompile += %w( website.css )
      app.config.assets.precompile += %w[ website_manifest ]
    end

    initializer "website.importmap", before: "importmap" do |app|
      app.config.importmap.paths << root.join("config/importmap.rb")
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end
  end
end

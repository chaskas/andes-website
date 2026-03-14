module Website
  class ApplicationController < ::ApplicationController
    skip_before_action :authenticate_user! unless Rails.env.test?
    before_action :set_locale

    private

    def set_locale
      if params[:locale].present? && I18n.available_locales.map(&:to_s).include?(params[:locale])
        session[:locale] = params[:locale]
      end
      I18n.locale = session[:locale] || I18n.default_locale
    end
  end
end

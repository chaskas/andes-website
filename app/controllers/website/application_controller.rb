module Website
  class ApplicationController < ::ApplicationController
    skip_before_action :authenticate_user! unless Rails.env.test?
    before_action :set_locale

    private

    def set_locale
      if params[:locale].present? && %w[es en de].include?(params[:locale])
        session[:locale] = params[:locale]
      end
      I18n.locale = session[:locale] || :es
    end
  end
end

module Website
  class ApplicationController < ::ApplicationController
    skip_before_action :authenticate_user! unless Rails.env.test?
    around_action :switch_locale

    private

    def switch_locale(&action)
      if params[:locale].present? && %w[es en de].include?(params[:locale])
        session[:locale] = params[:locale]
      end
      locale = session[:locale] || :es
      I18n.with_locale(locale, &action)
    end
  end
end

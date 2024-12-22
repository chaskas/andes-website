module Website
  class ApplicationController < ::ApplicationController

    skip_before_action :authenticate_user! if !Rails.env.test?

  end
end

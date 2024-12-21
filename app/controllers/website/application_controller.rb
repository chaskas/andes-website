module Website
  class ApplicationController < ::ApplicationController

    skip_before_action :authenticate_user!

  end
end

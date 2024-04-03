module Website
  class PagesController < ApplicationController
    def index
      render plain: "OK"
    end
  end
end

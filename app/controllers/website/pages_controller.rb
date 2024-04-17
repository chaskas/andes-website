module Website
  class PagesController < ApplicationController
    def index
      render plain: "Pages#Index"
    end
  end
end

module Website
  class ApplicantsController < ApplicationController
    def new
      @applicant = Applicant.new
    end

    def create
      unless valid_turnstile?
        redirect_to new_applicant_path, alert: t("website.turnstile.failed")
        return
      end

      @applicant = Applicant.new(applicant_params)

      if @applicant.save
        ApplicantMailer.notify(@applicant).deliver_now
        redirect_to new_applicant_path, notice: t("website.work_with_us.success")
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def applicant_params
      params.require(:applicant).permit(
        :name, :email, :phone, :profession, :location, :availability, :message
      )
    end

    # Provided by cloudflare-turnstile-rails gem in the main app
    unless method_defined?(:valid_turnstile?)
      def valid_turnstile?
        true
      end
    end
  end
end

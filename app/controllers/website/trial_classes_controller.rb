# frozen_string_literal: true

module Website
  class TrialClassesController < ApplicationController
    def index
      @trial_classes = fetch_trial_classes
    end

    def thank_you
    end

    private

    def fetch_trial_classes
      Rails.cache.fetch("trial_classes", expires_in: 5.minutes) do
        School::SessionDetail.trial_classes_with_future_sessions
      end
    rescue StandardError => e
      Rails.logger.warn("Trial classes error: #{e.message}")
      []
    end
  end
end

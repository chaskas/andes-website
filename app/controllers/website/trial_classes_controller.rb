# frozen_string_literal: true

module Website
  class TrialClassesController < ApplicationController
    def index
      @trial_classes = fetch_trial_classes
    end

    private

    def fetch_trial_classes
      Rails.cache.fetch("trial_classes", expires_in: 5.minutes) do
        fetch_from_api
      end
    end

    def fetch_from_api
      uri = URI("#{request.base_url}/school/api/v1/trial_classes.json")
      response = Net::HTTP.get_response(uri)
      return [] unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    rescue StandardError => e
      Rails.logger.warn("Trial classes API error: #{e.message}")
      []
    end
  end
end

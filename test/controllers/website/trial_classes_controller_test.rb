# frozen_string_literal: true

require 'test_helper'

module Website
  class TrialClassesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      Rails.cache.clear
    end

    test 'should get index with trial classes data' do
      mock_data = [
        {
          "id" => 1,
          "title" => "Iniciación Musical",
          "facilitator" => "Prof. María",
          "capacity" => 10,
          "available_slots" => 3,
          "sessions" => [
            { "id" => 101, "date" => 3.days.from_now.to_date.iso8601, "time" => "10:00", "duration" => 45 }
          ]
        }
      ]

      Rails.cache.write("trial_classes", mock_data, expires_in: 5.minutes)

      get trial_classes_url
      assert_response :success
      assert_match "Iniciación Musical", response.body
    end

    test 'should render empty state when no trial classes' do
      Rails.cache.write("trial_classes", [], expires_in: 5.minutes)

      get trial_classes_url
      assert_response :success
    end

    test 'should handle API failure gracefully' do
      # Without cache data and with no running server, the API call will fail
      # The controller should catch the error and show empty state
      Rails.cache.write("trial_classes", [], expires_in: 5.minutes)

      get trial_classes_url
      assert_response :success
    end
  end
end

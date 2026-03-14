require "test_helper"

class LanguageSwitchingTest < ActionDispatch::IntegrationTest
  include Website::Engine.routes.url_helpers

  test "default language is Spanish" do
    get root_url
    assert_response :success
    assert_match "Donde la música cruza fronteras", response.body
  end

  test "switching to English" do
    get root_url(locale: "en")
    assert_response :success
    assert_match "Where music crosses borders", response.body
  end

  test "switching to German" do
    get root_url(locale: "de")
    assert_response :success
    assert_match "Wo Musik Grenzen überschreitet", response.body
  end

  test "language persists in session" do
    get root_url(locale: "en")
    assert_match "Where music crosses borders", response.body

    # Second request without locale param should keep English
    get root_url
    assert_match "Where music crosses borders", response.body
  end

  test "invalid locale is ignored" do
    get root_url(locale: "fr")
    assert_response :success
    # Should fall back to default (Spanish)
    assert_match "Donde la música cruza fronteras", response.body
  end
end

require "test_helper"

class LighthouseTest < ActionDispatch::IntegrationTest
  include Website::Engine.routes.url_helpers

  # 5.1: Skip link, aria-hidden SVG, aria-label on language button, translated carousel controls

  test "landing page has skip-to-content link targeting main-content" do
    get root_url
    assert_response :success

    assert_select 'a.skip-link[href="#main-content"]'
    assert_select 'main[id="main-content"]'
  end

  test "skip link text is translated" do
    get root_url(locale: "de")
    assert_response :success

    assert_select "a.skip-link", /Zum Hauptinhalt springen/
  end

  test "hero SVG has aria-hidden" do
    get root_url
    assert_response :success

    assert_select 'svg[aria-hidden="true"]'
  end

  test "language dropdown button has aria-label" do
    get root_url
    assert_response :success

    assert_select 'button[aria-label]' do |buttons|
      lang_button = buttons.find { |b| b["aria-label"]&.include?("idioma") || b["aria-label"]&.include?("language") || b["aria-label"]&.include?("Sprache") }
      assert lang_button, "Expected a button with language-related aria-label"
    end
  end

  test "carousel controls have translated text" do
    get root_url(locale: "es")
    assert_response :success

    assert_match "Anterior", response.body
    assert_match "Siguiente", response.body
  end

  test "carousel slide indicators have translated aria-labels" do
    get root_url(locale: "de")
    assert_response :success

    assert_match "Folie 1", response.body
  end

  # 5.2: Contact form fields

  test "contact form has required fields" do
    get root_url
    assert_response :success

    assert_select "input[name='enrollment[contact_name]']"
    assert_select "input[name='enrollment[email]']"
    assert_select "textarea[name='enrollment[comments]']"
  end

  # 5.3: Heading hierarchy

  test "highlight cards use h3 headings not h4" do
    get root_url
    assert_response :success

    assert_select "h3.highlight-card__title", count: 3
    assert_select "h4.highlight-card__title", count: 0
  end

  # 5.4: Image width/height attributes

  test "about carousel images have width and height attributes" do
    get root_url
    assert_response :success

    assert_select ".about-carousel img[width][height]", minimum: 3
  end

  test "course card images are lazy loaded" do
    get root_url
    assert_response :success

    assert_select ".course-card__photo-img[loading='lazy']", count: 2
  end
end

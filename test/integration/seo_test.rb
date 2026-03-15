require "test_helper"

class SeoTest < ActionDispatch::IntegrationTest
  include Website::Engine.routes.url_helpers

  # Task 4.1: Meta tags tests

  test "landing page includes Open Graph meta tags" do
    get root_url
    assert_response :success

    assert_select 'meta[property="og:title"]'
    assert_select 'meta[property="og:description"]'
    assert_select 'meta[property="og:type"][content="website"]'
    assert_select 'meta[property="og:url"]'
    assert_select 'meta[property="og:image"]'
    assert_select 'meta[property="og:locale"]'
  end

  test "landing page includes Twitter Card meta tags" do
    get root_url
    assert_response :success

    assert_select 'meta[name="twitter:card"][content="summary_large_image"]'
    assert_select 'meta[name="twitter:title"]'
    assert_select 'meta[name="twitter:description"]'
    assert_select 'meta[name="twitter:image"]'
  end

  test "landing page includes canonical URL without locale" do
    get root_url(locale: "en")
    assert_response :success

    assert_select 'link[rel="canonical"]' do |elements|
      href = elements.first["href"]
      assert_not_includes href, "locale"
    end
  end

  test "landing page includes hreflang tags for all locales" do
    get root_url
    assert_response :success

    assert_select 'link[rel="alternate"][hreflang="es"]'
    assert_select 'link[rel="alternate"][hreflang="en"]'
    assert_select 'link[rel="alternate"][hreflang="de"]'
    assert_select 'link[rel="alternate"][hreflang="x-default"]'
  end

  test "landing page includes favicon link tags" do
    get root_url
    assert_response :success

    assert_select 'link[rel="icon"]'
    assert_select 'link[rel="apple-touch-icon"]'
  end

  test "OG locale matches current locale" do
    get root_url(locale: "de")
    assert_response :success

    assert_select 'meta[property="og:locale"][content="de_DE"]'
  end

  # Task 4.2: Structured data tests

  test "landing page includes Organization JSON-LD" do
    get root_url
    assert_response :success

    assert_match '"@type": "Organization"', response.body
    assert_match '"name": "Andes Academy"', response.body
  end

  test "landing page includes MusicSchool JSON-LD" do
    get root_url
    assert_response :success

    assert_match '"@type": "MusicSchool"', response.body
    assert_match '"addressLocality": "Berlin"', response.body
  end

  test "landing page includes Course JSON-LD for both courses" do
    get root_url
    assert_response :success

    assert_match '"@type": "Course"', response.body
    # Default locale is Spanish
    assert_match "Clases de Piano", response.body
    assert_match "Iniciación Musical", response.body
  end

  test "Course JSON-LD is localized for English" do
    get root_url(locale: "en")
    assert_response :success

    assert_match "Piano Lessons", response.body
    assert_match "Musical Initiation", response.body
  end

  # Task 4.3: Sitemap tests

  test "sitemap.xml returns valid XML" do
    get sitemap_url(format: :xml)
    assert_response :success
    assert_equal "application/xml; charset=utf-8", response.content_type
  end

  test "sitemap.xml contains hreflang alternates" do
    get sitemap_url(format: :xml)
    assert_response :success

    assert_includes response.body, 'hreflang="es"'
    assert_includes response.body, 'hreflang="en"'
    assert_includes response.body, 'hreflang="de"'
    assert_includes response.body, 'hreflang="x-default"'
  end
end

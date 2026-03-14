require "test_helper"

class NavigationTest < ActionDispatch::IntegrationTest
  include Website::Engine.routes.url_helpers

  test "landing page renders all sections" do
    get root_url
    assert_response :success

    # Hero section
    assert_select "#inicio"
    assert_select "h1", /Andes Academy/

    # About section
    assert_select "#sobre"

    # Courses section
    assert_select "#cursos"

    # Contact/Enrollment section
    assert_select "#contacto"

    # Footer
    assert_select "footer"
  end

  test "landing page shows hero highlights" do
    get root_url
    assert_response :success

    assert_match I18n.t("website.hero.highlights.community.title"), response.body
    assert_match I18n.t("website.hero.highlights.heart.title"), response.body
    assert_match I18n.t("website.hero.highlights.ages.title"), response.body
  end

  test "landing page shows both courses" do
    get root_url
    assert_response :success

    assert_match I18n.t("website.courses.piano.title"), response.body
    assert_match I18n.t("website.courses.initiation.title"), response.body
  end

  test "landing page shows enrollment form" do
    get root_url
    assert_response :success

    assert_select "form[action=?]", enrollments_path
    assert_select "input[name='enrollment[student_name]']"
    assert_select "input[name='enrollment[email]']"
  end
end

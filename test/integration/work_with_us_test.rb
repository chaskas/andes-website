require "test_helper"

class WorkWithUsTest < ActionDispatch::IntegrationTest
  include Website::Engine.routes.url_helpers

  test "work with us page renders" do
    get new_applicant_url
    assert_response :success
    assert_select "h1", /Trabaja con nosotros/
  end

  test "work with us page has application form" do
    get new_applicant_url
    assert_response :success
    assert_select "form"
    assert_select "input[name='applicant[name]']"
    assert_select "input[name='applicant[email]']"
    assert_select "input[name='applicant[profession]']"
    assert_select "input[name='applicant[location]']"
    assert_select "input[name='applicant[availability]']"
  end

  test "navbar has work with us link" do
    get root_url
    assert_response :success
    assert_select "a.nav-link", text: /Trabaja con nosotros/
  end

  test "navbar links use full paths with anchors" do
    get new_applicant_url
    assert_response :success
    assert_select "a.nav-link[href*='#inicio']"
    assert_select "a.nav-link[href*='#cursos']"
  end

  test "work with us page renders in German" do
    get new_applicant_url(locale: "de")
    assert_response :success
    assert_select "h1", /Arbeiten Sie mit uns/
  end
end

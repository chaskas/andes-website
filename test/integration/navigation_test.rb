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

    # Page renders in Spanish by default
    assert_match "Comunidad Multicultural", response.body
    assert_match "Desde el Corazón", response.body
    assert_match "Para Todas las Edades", response.body
  end

  test "landing page shows both courses" do
    get root_url
    assert_response :success

    assert_match "Clases de Piano", response.body
    assert_match "Iniciación Musical", response.body
  end

  test "landing page shows enrollment form" do
    get root_url
    assert_response :success

    assert_select "form[action=?]", enrollments_path
    assert_select "input[name='enrollment[student_name]']"
    assert_select "input[name='enrollment[email]']"
  end
end

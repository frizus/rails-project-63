# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_tag_build
    assert_equal("<br>", HexletCode::Tag.build("br"))
    assert_equal("<img src=\"path/to/image\">", HexletCode::Tag.build("img", src: "path/to/image"))
    assert_equal("<input type=\"submit\" value=\"Save\">",
                 HexletCode::Tag.build("input", type: "submit", value: "Save"))
    assert_equal("<label>Email</label>", HexletCode::Tag.build("label") { "Email" })
    assert_equal("<label for=\"email\">Email</label>", HexletCode::Tag.build("label", for: "email") { "Email" })
    assert_equal("<div></div>", HexletCode::Tag.build("div"))
  end

  def test_form_for
    user_class = Struct.new(:name, :job, keyword_init: true)
    user = user_class.new name: "rob"

    assert_equal("<form action=\"#\" method=\"post\"></form>", HexletCode.form_for(user))
    assert_equal("<form action=\"/users\" method=\"post\"></form>", HexletCode.form_for(user, { url: "/users" }))
  end
end

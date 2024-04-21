# frozen_string_literal: true

require "test_helper"

class TestHexletCode < ActiveSupport::TestCase
  include Rails::Dom::Testing::Assertions::DomAssertions

  def fixture(relative_path)
    File.read(File.expand_path(relative_path, __dir__))
  end

  def test_tag_build
    assert_dom_equal("<br>", HexletCode::Tag.build("br"))
    assert_dom_equal("<img src=\"path/to/image\">", HexletCode::Tag.build("img", src: "path/to/image"))
    assert_dom_equal("<input type=\"submit\" value=\"Save\">",
                     HexletCode::Tag.build("input", type: "submit", value: "Save"))
    assert_dom_equal("<label>Email</label>", HexletCode::Tag.build("label") { "Email" })
    assert_dom_equal("<label for=\"email\">Email</label>", HexletCode::Tag.build("label", for: "email") { "Email" })
    assert_dom_equal("<div></div>", HexletCode::Tag.build("div"))
  end

  def test_form_for
    user_class = Struct.new(:name, :job, keyword_init: true)
    user = user_class.new name: "rob"

    assert_dom_equal("<form action=\"#\" method=\"post\"></form>", HexletCode.form_for(user))
    assert_dom_equal("<form action=\"/users\" method=\"post\"></form>", HexletCode.form_for(user, { url: "/users" }))
  end

  def test_form_inputs
    user_class = Struct.new(:name, :job, :gender, keyword_init: true)
    user = user_class.new name: "rob", job: "hexlet", gender: "m"

    result = HexletCode.form_for(user) do |f|
      f.input :name, no_label: true
      f.input :job, as: :text, no_label: true
    end
    assert_dom_equal(fixture("fixtures/test_inputs/test_default.html"), result)
    result = HexletCode.form_for(user) do |f|
      f.input :name, class: "user-input", no_label: true
      f.input :job, class: "different-user-input", no_label: true
    end
    assert_dom_equal(fixture("fixtures/test_inputs/test_both_as_input_with_classes.html"), result)
    result = HexletCode.form_for(user) do |f|
      f.input :job, as: :text, rows: 50, cols: 50, no_label: true
    end
    assert_dom_equal(fixture("fixtures/test_inputs/test_one_as_textarea.html"), result)
    result = HexletCode.form_for(user)
    assert_dom_equal(fixture("fixtures/test_inputs/test_no_inputs.html"), result)
  end

  def test_form_inputs_with_labels
    user_class = Struct.new(:name, :job, keyword_init: true)
    user = user_class.new job: "hexlet"

    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    assert_dom_equal(fixture("fixtures/test_inputs_with_labels/test_submit_default_value.html"), result)

    result = HexletCode.form_for user, url: "#" do |f|
      f.input :name
      f.input :job
      f.submit "Wow"
    end
    assert_dom_equal(fixture("fixtures/test_inputs_with_labels/test_submit_with_set_value.html"), result)
  end
end

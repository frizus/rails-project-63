# frozen_string_literal: true

require "test_helper"

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_tag_build
    assert_equal("<br>", HexletCode::Tag.build('br'))
    assert_equal("<img src=\"path/to/image\">", HexletCode::Tag.build('img', src: 'path/to/image'))
    assert_equal("<input type=\"submit\" value=\"Save\">", HexletCode::Tag.build('input', type: 'submit', value: 'Save'))
    assert_equal("<label>Email</label>", HexletCode::Tag.build('label') { 'Email' })
    assert_equal("<label for=\"email\">Email</label>", HexletCode::Tag.build('label', for: 'email') { 'Email' })
    assert_equal("<div></div>", HexletCode::Tag.build('div'))
  end
end

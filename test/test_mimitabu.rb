# frozen_string_literal: true

require "test_helper"

class TestMimitabu < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mimitabu::VERSION
  end
end

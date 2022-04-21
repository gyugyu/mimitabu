# frozen_string_literal: true

require "test_helper"

class TestRuntime < Minitest::Test
  def test_runtime_run
    runtime = Mimitabu::Runtime.new(
      Mimitabu::Configuration.new({
        autoload_code_paths: [File.expand_path(__dir__, "fixtures/step_definitions")],
        feature_file_paths: [File.expand_path(__dir__, "fixtures/features")],
      })
    )
    runtime.run
  end
end

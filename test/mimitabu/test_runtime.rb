# frozen_string_literal: true

require "test_helper"

class TestRuntime < Minitest::Test
  def test_runtime_run
    runtime = Mimitabu::Runtime.new(
      Mimitabu::Configuration.new({
                                    autoload_code_paths: [File.expand_path("fixtures/step_definitions", __dir__)],
                                    feature_file_paths: [File.expand_path("fixtures/features", __dir__)]
                                  })
    )
    runtime.run
  end
end

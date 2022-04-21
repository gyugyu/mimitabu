# frozen_string_literal: true

sequence(:sequence_test) { |i| "sequence-string-#{i}" }
sequence(:another_sequence_test) { |i| "sequence-string-2-#{i}" }

step("Premise", sequence: :sequence_test) do |seq|
  { key: seq[:sequence_test] }
end

step("Condition", sequence: :another_sequence_test) do |data, _option, seq|
  { key: data[:key] + seq[:another_sequence_test] }
end

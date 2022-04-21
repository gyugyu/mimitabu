sequence(:sequence_test) { |i| "sequence-string-#{i}" }
sequence(:sequence_test_2) { |i| "sequence-string-2-#{i}" }

step("Premise", sequence: :sequence_test) do |seq|
  {key: seq[:sequence_test]}
end

step("Condition", sequence: :sequence_test_2) do |data, option, seq|
  {key: data[:key] + seq[:sequence_test_2]}
end

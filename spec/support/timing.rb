def time_it
  starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  yield
  ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  ending - starting
end

RSpec.configure do |c|
  c.around do |example|
    elapsed = time_it { example.run }
    threshold = example.metadata[:fail_if_slower_than]
    fail "Expected test to finish in #{threshold}s, took #{elapsed}."  if !threshold.nil? && threshold < elapsed
  end
end
require 'benchmark_helper'

class ApiTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory], output: 'tmp/performance', formats: [:flat] }

  test "homepage" do
    get '/v1/products'
  end
end

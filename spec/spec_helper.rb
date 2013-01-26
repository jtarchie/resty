require 'rubygems'
require 'resty'
require 'pry'

require 'support/integration'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before do
    ExampleApp::Post.create(id: 1, title: "Title")
    ExampleApp::Post.create(id: 2, title: "Title")
    ExampleApp::Post.create(id: 3, title: "Title")
  end

  config.after do
    ExampleApp::Post.delete_all
  end
end

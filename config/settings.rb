require 'ostruct'

Settings = OpenStruct.new(
  :dashboard_title  => "Picasso dashboard",
  :db               => "db/test.sqlite",
  :api_user         => "api",
  :api_pass         => "b7273d35bb1926e56a9671fca815c99b",
  :data             => {
    :step             => 5 * 60 * 1000,
    :samples_per_page => 1200,
    :sources          => [
      ['server1', 'CPU']
    ]
  }
)

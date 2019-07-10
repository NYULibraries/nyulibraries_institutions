source "https://rubygems.org"

gemspec

group :development, :test do
    # Allows for testing against multiple rails versions
  rails_version = ENV["RAILS_VERSION"] || "default"

  rails =
    case rails_version
    when "master"
      { github: "rails/rails" }
    when "default"
      ">= 4"
    else
      "~> #{rails_version}"
    end
  gem "rails", rails
  gem 'sqlite3', '~> 1.3.6'
end
require 'nyulibraries_institutions/version'
require 'institutions'

module NyulibrariesInstitutions
  class << self
    # modified from bootstrap-sass gem
    def load!
      register_rails_engine if rails?
    end

    def rails?
      defined?(::Rails)
    end

    private

    def register_rails_engine
      require 'nyulibraries_institutions/engine'
    end
  end
end

NyulibrariesInstitutions.load!

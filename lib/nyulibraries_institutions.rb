require 'nyulibraries_institutions/version'
require 'institutions'

module NyulibrariesInstitutions
  class << self
    # modified from bootstrap-sass gem
    def load!
      register_rails_engine if rails?
      # add common configuration to front of loadpath
      Institutions.loadpaths.unshift(configuration_filepath)
      if rails? && !Rails.env.production?
        Institutions.filenames << 'institutions.qa.yml'
        Institutions.filenames << 'institutions.dev.yml'
      end
    end

    def rails?
      defined?(::Rails)
    end

    private

    def register_rails_engine
      require 'nyulibraries_institutions/engine'
    end

    def configuration_filepath
      File.join(File.dirname(__FILE__), '../', 'config')
    end
  end
end

NyulibrariesInstitutions.load!

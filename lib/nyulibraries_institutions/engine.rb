module NyulibrariesInstitutions
  class Engine < ::Rails::Engine
    # So we don't overlap in client namespace
    isolate_namespace NyulibrariesInstitutions

    # Include the helper in the client application
    initializer "nyulibraries_templates.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include NyulibrariesInstitutions::InstitutionHelper
      end
    end

    initializer "nyulibraries_templates.controller_helpers" do
      ActiveSupport.on_load(:action_controller) do
        include NyulibrariesInstitutions::InstitutionHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end
  end
end

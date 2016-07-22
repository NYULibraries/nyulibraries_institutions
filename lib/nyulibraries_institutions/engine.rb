module NyulibrariesInstitutions
  class Engine < ::Rails::Engine
    # So we don't overlap in client namespace
    isolate_namespace NyulibrariesInstitutions

    # Include the view path in the client application
    ActionController::Base.append_view_path(File.join(root, 'app', 'templates', 'nyulibraries_templates'))

    # Include the helper in the client application
    config.to_prepare do
      ApplicationController.helper(NyulibrariesInstitutions::InstitutionHelper)

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

module NyulibrariesInstitutions
  module InstitutionHelper
    # Override Rails #url_for to add institution
    def url_for_institution(options={})
      if institution_param.present? && options.is_a?(Hash)
        options[institution_param_name] ||= institution_param
      end
      url_for(options)
    end

    # Get the stylesheet base on the current institution.
    def institutional_stylesheet
      stylesheet_link_tag current_institution.views["css"]
    end

    def institution_views
      current_institution.views
    end

    def default_institution
      @default_institution ||= Institutions.defaults.first
    end

    # Determine current primary institution based on:
    #   0. institutions are not being used (returns nil)
    #   1. institution query string parameter in URL
    #   2. institution associated with the client IP
    #   3. primary institution for the current user
    #   4. first default institution
    def current_institution
      @current_institution ||= get_current_institution
    end
    alias current_primary_institution current_institution
    alias institution current_institution

    def institution_from_current_user
      @institution_from_current_user ||= begin
        if defined?(current_user) && current_user && current_user.respond_to?(:institution_code) && current_user.institution_code.present?
          institutions[current_user.institution_code.to_sym]
        end
      end
    end

    # Default param name is institution
    # can be overridden in local applications
    def institution_param_name
      'institution'
    end

    # Grab the first institution that matches the client IP
    def institution_from_ip
      unless request.nil?
        @institution_from_ip ||= begin
          institutions_from_ip = institutions.find_all { |_code, institution| institution.includes_ip? request.remote_ip }
          if institutions_from_ip.present?
            # Get first matching institution and get the last element from
            # [:NYU, Institution] array, that is, the actual Institution object
            institutions_from_ip.first.last
          end
        end
      end
    end

    # All institutions
    def institutions
      # Reset ip_addresses with the protected setter
      # to separate IP ranges as a string into IPRange objects
      # See institutions gem: https://github.com/scotdalton/institutions/blob/745b26efb082bec055818baf61a112f4f99db657/lib/institutions/institution/ip_addresses.rb#L6-L12
      @institutions ||= Institutions.institutions.each do |_code, institution|
        unless institution.ip_addresses.nil? || institution.ip_addresses.is_a?(IPAddrRangeSet)
          institution.send("ip_addresses=", ip_addresses_for(institution))
        end
      end
    end

    private

    # The institution param as a Symbol
    def institution_param
      params[institution_param_name].upcase.to_sym if params[institution_param_name].present?
    end

    # Get the IP addresses for an individual institution after it's already been loaded
    # I don't like this but we need it to get around the fact that Institutions
    # deep merges with parent institutions and so IPs don't match one specific
    # institution but the parent
    def ip_addresses_for(institution)
      varname = "@ip_addresses_for_#{institution.code.to_s.downcase}"
      ip_addresses_for_institution = self.instance_variable_get(varname)
      if ip_addresses_for_institution.nil?
        self.instance_variable_set(varname, reload_ip_addresses_for(institution))
      else
        ip_addresses_for_institution
      end
    end

    # Take a page from the institutions gem and reload just the ip_addresses
    # as an array for the given institution
    def reload_ip_addresses_for(institution)
      institution_ip_addresses = []
      Institutions.loadfiles.each do |loadfile|
        # Loop through institutions in the yaml
        YAML.load(ERB.new(File.read(loadfile)).result).each_pair do |code, elements|
          code = code.to_sym
          if institution.code == code
            ip_addresses = elements[:ip_addresses] || elements["ip_addresses"]
            if ip_addresses
              institution_ip_addresses << ip_addresses
            end
          end
        end
      end
      institution_ip_addresses.flatten.uniq
    end

    # Get the institution from a given code
    def institution_from_code(code)
      unless code.nil?
        @institution_from_code ||= institutions[code.upcase.to_sym]
      end
    end

    def get_current_institution
      case
      when (institution_param.present? && institutions[institution_param])
        institutions[institution_param]
      when institution_from_ip.present?
        institution_from_ip
      when (institution_from_current_user.present?)
        institution_from_current_user
      else
        default_institution
      end
    end
  end
end

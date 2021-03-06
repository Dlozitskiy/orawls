module Puppet
  Type.newtype(:wls_directory_structure) do
    desc 'add all the directories needed by the oracle weblogic installation'

    newparam(:name) do
      desc <<-EOT
        The title.
      EOT
      isnamevar
    end

    newproperty(:ensure) do
      desc 'Whether to do something.'

      newvalue(:present) do
        provider.configure
      end

      def retrieve
        oracle_base     = resource[:oracle_base_dir]
        ora_inventory   = resource[:ora_inventory_dir]
        download_folder = resource[:download_dir]
        middleware_home = resource[:ora_middleware_home]
        temp_folder     = resource[:temp_directory]


        if File.exist?(oracle_base) && File.exist?(ora_inventory) && File.exist?(download_folder) && File.exist?(middleware_home) && File.exist?(temp_folder) 
          :present
        else
          :absent
        end
      end

    end

    newparam(:oracle_base_dir) do
      desc <<-EOT
        The oracle base folder.
      EOT
      validate do |value|
        if value.nil?
          fail ArgumentError, 'oracle_base_dir cannot be empty'
        end
      end
    end

    newparam(:ora_inventory_dir) do
      desc <<-EOT
        The oracle inventory folder.
      EOT
      validate do |value|
        if value.nil?
          fail ArgumentError, 'ora_inventory_dir cannot be empty'
        end
      end
    end

    newparam(:ora_middleware_home) do
      desc <<-EOT
        The middleware home folder.
      EOT
      validate do |value|
        if value.nil?
          fail ArgumentError, 'ora_middleware_home cannot be empty'
        end
      end
    end

    newparam(:temp_directory) do
      desc <<-EOT
        The temp folder.
      EOT
      validate do |value|
        if value.nil?
          fail ArgumentError, 'Temp folder cannot be empty'
        end
      end
    end

    newparam(:download_dir) do
      desc <<-EOT
        The download folder.
      EOT
      validate do |value|
        if value.nil?
          fail ArgumentError, 'download_dir cannot be empty'
        end
      end
    end

    newparam(:os_user) do
      desc <<-EOT
        The weblogic operating system user.
      EOT

      defaultto 'oracle'
    end

    newparam(:os_group) do
      desc <<-EOT
        The weblogic operating system group.
      EOT

      defaultto 'dba'
    end

  end
end

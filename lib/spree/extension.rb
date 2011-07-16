module Spree
  class Extension < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__) + '/templates'
    end

    desc "generate NAME", "generate extension"
    def generate(name)

      class_path = name.include?('/') ? name.split('/') : name.split('::')
      class_path.map! { |m| m.underscore }
      self.file_name = 'spree_' + class_path.pop
      self.human_name = name.titleize
      self.class_name = name.classify

      empty_directory file_name
      empty_directory "#{file_name}/config"
      empty_directory "#{file_name}/db"
      empty_directory "#{file_name}/public"
      empty_directory "#{file_name}/app"
      empty_directory "#{file_name}/app/controllers"
      empty_directory "#{file_name}/app/helpers"
      empty_directory "#{file_name}/app/models"
      empty_directory "#{file_name}/app/views"
      empty_directory "#{file_name}/spec"
      directory "lib", "#{file_name}/lib"

      template "LICENSE", "#{file_name}/LICENSE"
      template "Rakefile.tt", "#{file_name}/Rakefile"
      template "README.md", "#{file_name}/README.md"
      template "gitignore.tt", "#{file_name}/.gitignore"
      template "extension.gemspec.tt", "#{file_name}/#{file_name}.gemspec"
      template "Versionfile.tt", "#{file_name}/Versionfile"
      template "routes.rb", "#{file_name}/config/routes.rb"
      template "install.rake.tt", "#{file_name}/lib/tasks/install.rake"
      template "spec_helper.rb", "#{file_name}/spec/spec_helper.rb"
      template 'hooks.rb.tt', "#{file_name}/lib/#{file_name}_hooks.rb"
      template 'extension.rb.tt', "#{file_name}/lib/#{file_name}.rb"

      #Add the extension to Gemfile when applicable
      if File.exist? 'Gemfile'
        append_to_file 'Gemfile' do
          "\ngem '#{file_name}', :path => '#{file_name}', :require => '#{file_name}'\n"
        end
      end

    end

    no_tasks do
      # File/Lib Name (ex. paypal_express)
      attr_accessor :file_name
    end

    no_tasks do
      # Human Readable Name (ex. Paypal Express)
      attr_accessor :human_name
    end

    no_tasks do
      # Class Name (ex. PaypalExpress)
      attr_accessor :class_name
    end
  end
end


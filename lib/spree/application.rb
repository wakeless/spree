module Spree
  class Application < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__) + '/templates'
    end

    desc "generate NAME", "generate sandbox"
    def generate(name, options)
      remove_directory_if_exists(name) if options[:clean]

      run "rails new #{name} -GJT"

      inside name do
        append_to_file 'Gemfile' do
<<-gems

gem 'spree', :path => '../'

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gems
        end

        run 'rails g spree:site -f'

        run_silent 'rake spree:install'
        run_silent 'rake spree_sample:install' if options[:sample]
        run_silent 'rake db:bootstrap AUTO_ACCEPT=true' if options[:bootstrap]
      end

    end

    private
    def remove_directory_if_exists(path)
      run "rm -r #{path}" if File.directory?(path)
    end

    # runs a command and silences the output (other than a simple status message)
    def run_silent(cmd)
      say_status "run", cmd
      silence_stream(STDOUT) { run cmd }
    end

  end
end

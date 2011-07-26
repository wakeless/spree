module Spree
  class Test < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__) + '/templates'
      File.dirname(__FILE__) + '/../../..'
    end

    desc "generate DIR", "generate core/spec"
    def generate(test_app)
      inside test_app do
        template "../../../Gemfile", :force => true
        remove_file "Gemfile.lock"
      end
    end
  end
end

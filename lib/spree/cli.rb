require "rubygems"
#require "date"
require "spree_core/version"
#require "rails/generators"
require "thor"
require 'spree/extension'

module Spree
  class CLI < Thor
    def self.basename
      "spree"
    end

    map "-v"        => "version"
    map "--version" => "version"

    desc "version", "print the current version"
    def version
      shell.say "Spree #{Spree.version}", :green
    end

    desc "extension NAME", "create a new extension with the given name"
    method_option "name", :type => :string
    def extension(name)
      invoke "spree:extension:generate", [options[:name] || name]
    end
  end
end

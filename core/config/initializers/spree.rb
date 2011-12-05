require 'mail'

# Spree Configuration
SESSION_KEY = '_spree_session_id'

# TODO - Add the lib/plugins stuff maybe?
#::ActiveRecord::Base.send :include, Spree::Preferences::Preferable

if Spree::MailMethod.table_exists?
  Spree::Core::MailSettings.init
  Mail.register_interceptor(Spree::Core::MailInterceptor)
end

# Add extra support goodies (similar to rails active support)
#class Array #:nodoc:
#  include Spree::Support::CoreExtensions::Array
#end

String.class_eval do
  include Spree::Core::Ext::String
end

LIKE = ActiveRecord::Base.connection.adapter_name == 'PostgreSQL' ? 'ILIKE' : 'LIKE'

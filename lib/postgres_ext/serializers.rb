require 'postgres_ext'
require 'postgres_ext/serializers/version'
begin
  require 'active_model/serializers/version'
rescue LoadError
  # AMS 0.9 and later uses different path
  require 'active_model/serializer/version'
end

module PostgresExt
  module Serializers
    AMS_VERSION = ActiveModel::Serializer::VERSION[/^\d+\.\d+/].freeze
  end
end

require 'postgres_ext/serializers/active_model'
require 'active_model_serializers'

ActiveModel::ArraySerializer.send :prepend, PostgresExt::Serializers::ActiveModel::ArraySerializer
case PostgresExt::Serializers::AMS_VERSION
when '0.8'
  ActiveModel::Serializer.send :prepend, PostgresExt::Serializers::ActiveModel::Serializer
when '0.9'
  require 'postgres_ext/serializers/action_controller'
  ActionController::Serialization.send :prepend, PostgresExt::Serializers::ActionController::Serialization
end

require './services/importer/importers/user_validation/user_exceptions'

module Importer
  module Importers
    module UserValidation
      # User validation logic before creating a user object
      class UserValidator
        include Importer::Importers::UserValidation::UserExceptions
        attr_reader :errors

        def initialize(user_hash)
          @user_hash = user_hash
          @errors = []
        end

        def perform
          validate_lat
          validate_lng
          validate_name
          validate_id
        end

        def valid?
          errors.empty?
        end

        private

        def validate_lat
          raise MissingLat if attr_empty?('latitude')
          raise LatOutOFRange unless in_range?('latitude', -90, 90)
        rescue MissingLat
          @errors << "#{@user_hash} has missing latitude"
        rescue LatOutOFRange
          @errors << "#{@user_hash} latitude is out of range"
        end

        def validate_lng
          raise MissingLng if attr_empty?('longitude')
          raise LngOutOfRange unless in_range?('longitude', -180, 180)
        rescue MissingLng
          @errors << "#{@user_hash} has missing longitude"
        rescue LngOutOfRange
          @errors << "#{@user_hash} longitude is out of range"
        end

        def validate_name
          raise MissingName if attr_empty?('name')
        rescue MissingName
          @errors << "#{@user_hash} has missing name"
        end

        def validate_id
          raise MissingId if attr_empty?('user_id')
        rescue MissingId
          @errors << "#{@user_hash} has missing user_id"
        end

        def attr_empty?(attr)
          @user_hash[attr].nil? || @user_hash[attr] == ''
        end

        def in_range?(attr, min, max)
          @user_hash[attr].to_f.between?(min, max)
        end
      end
    end
  end
end

require './services/importer/importer_interface'
require './entities/user'
require './services/geodesy/angle_converter'
require './services/geodesy/distance_calculator'
require './services/importer/importers/user_validation/user_validator'

module Importer
  module Importers
    # Implementation of user importer
    class User
      include Importer::ImporterInterface

      def initialize(file_path, origin_point, data_store)
        super(file_path, data_store)
        @origin_point = convert_point(*origin_point)
      end

      def perform
        import do |user_hash|
          validator = init_validator(user_hash)
          validator.perform
          if validator.valid?
            build_user(user_hash)
          else
            puts(validator.errors)
          end
        end
      end

      private

      def init_validator(user_hash)
        Importer::Importers::UserValidation::UserValidator.new(user_hash)
      end

      def build_user(user_hash)
        Entities::User.new(user_hash['user_id'].to_i,
                           user_hash['name'],
                           distance(user_hash))
      end

      def distance(user_hash)
        Geodesy::DistanceCalculator.new(@origin_point, user_point(user_hash))
                                   .distance
      end

      def user_point(user_hash)
        convert_point(user_hash['latitude'].to_f, user_hash['longitude'].to_f)
      end

      def convert_point(lat, lng)
        {
          lat: convert_angle(lat),
          lng: convert_angle(lng)
        }
      end

      def convert_angle(angle)
        Geodesy::AngleConverter.new(angle).convert_to_radian
      end
    end
  end
end

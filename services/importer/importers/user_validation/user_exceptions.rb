module Importer
  module Importers
    module UserValidation
      module UserExceptions
        class MissingLat < RuntimeError
        end

        class MissingLng < RuntimeError
        end

        class MissingId < RuntimeError
        end

        class MissingName < RuntimeError
        end

        class LatOutOFRange < RuntimeError
        end

        class LngOutOfRange < RuntimeError
        end
      end
    end
  end
end

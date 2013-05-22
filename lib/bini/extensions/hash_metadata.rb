module Bini
  module Extensions
    module HashMetadata
      extend self

      def metadata
        @metadata ||= Hash.new
      end

    end
  end
end

module Bini
  module Extensions
    module Metadata
      extend self

      def metadata
        @metadata ||= Hash.new
      end

    end
  end
end

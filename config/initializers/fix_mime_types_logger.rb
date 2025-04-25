require 'mime/types/logger'

module MIME
  class Types
    class WarnLogger < ::Logger
      # Accepte n'importe quels arguments sans utiliser _1, _2, _3
      def initialize(*args)
        super(nil)
        @logdev = WarnLogDevice.new
      end
    end
  end
end

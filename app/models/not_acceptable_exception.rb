class NotAcceptableException < StandardError
    attr_reader :message
    def initialize(message)
        @message = message
        super(message)
    end
end
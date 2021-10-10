# frozen_string_literal: true

class Logger
  class CustomLogFormatter < Formatter
    def call(severity, time, _progname, msg)
      "  [Level] #{severity} \n" \
        "   [Time] #{time} \n" \
        "[Message] #{msg} \n\n\n"
    end
  end
end

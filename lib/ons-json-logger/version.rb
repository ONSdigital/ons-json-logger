# frozen_string_literal: true

module ONSJSONLogger
  module Version
    MAJOR = 1
    MINOR = 0
    TINY  = 0
  end
  VERSION = [Version::MAJOR, Version::MINOR, Version::TINY].compact * '.'
end

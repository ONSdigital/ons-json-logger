# frozen_string_literal: true

require 'json'
require 'time'

# Class that generates structured JSON log entries.
class JSONLogger
  # Constructor that initialises the JSON logger.
  #
  # @param application [String] the name of the application
  # @param environment [String] the name of the environment the application is deployed to
  # @raise [ArgumentError] if application is nil
  def initialize(application:, environment: 'development')
    raise ArgumentError, 'application cannot be nil' if application.nil?

    @application = application
    @environment = environment
  end

  # Returns a structured JSON log entry from the passed arguments.
  #
  # @param level the log level e.g. +DEBUG+, +ERROR+, +INFO+
  # @param message the log message
  # @param module_name the name of the application module/component generating the log message
  # @param user optional Hash containing details of the user making the request such as username and IP address
  # @param http optional Hash containing details of the HTTP request such as the method, path, status code and user agent
  # @param error optional Hash containing details of an error that occurred such as the error code and message
  # @raise [ArgumentError] if level is nil
  # @raise [ArgumentError] if message is nil
  # @raise [ArgumentError] if module_name is nil
  def log(level:, message:, module_name:, user: {}, http: {}, error: {})
    raise ArgumentError, 'level cannot be nil' if level.nil?
    raise ArgumentError, 'message' if level.nil?
    raise ArgumentError, 'module_name cannot be nil' if level.nil?

    log_entry = {
      timestamp: Time.now.utc.iso8601,
      level:,
      message:,
      application: @application,
      environment: @environment,
      module: module_name
    }

    # Add optional fields if they are provided.
    log_entry[:user]  = user unless user.empty?
    log_entry[:http]  = http unless http.empty?
    log_entry[:error] = error unless error.empty?

    JSON.generate(log_entry)
  end
end

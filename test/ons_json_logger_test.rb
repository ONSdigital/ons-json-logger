# frozen_string_literal: true

require 'test/unit'

require_relative '../lib/ons-json-logger/json_logger'

class TestJSONLogger < Test::Unit::TestCase
  def setup
    @logger = JSONLogger.new(application: 'TestApp', environment: 'test')
  end

  def test_basic_log
    result = @logger.log(level: 'INFO', message: 'Test message', module_name: 'test_module')
    log_entry = JSON.parse(result)

    assert_equal 'INFO', log_entry['level']
    assert_equal 'Test message', log_entry['message']
    assert_equal 'TestApp', log_entry['application']
    assert_equal 'test', log_entry['environment']
    assert_equal 'test_module', log_entry['module']
  end

  def test_user_log
    user_info = { id: 'user123', client_ip: '192.168.0.1' }
    result = @logger.log(level: 'INFO', message: 'User test', module_name: 'auth', user: user_info)
    log_entry = JSON.parse(result)

    assert_equal user_info.transform_keys(&:to_s), log_entry['user'] # Convert keys to strings for comparison.
  end

  def test_http_log
    http_info = { method: 'POST', path: '/login', status: 200, user_agent: 'Mozilla/5.0' }
    result = @logger.log(level: 'INFO', message: 'HTTP test', module_name: 'request', http: http_info)
    log_entry = JSON.parse(result)

    assert_equal http_info.transform_keys(&:to_s), log_entry['http']
  end

  def test_error_log
    error_info = { code: 'AUTH_FAILURE', description: 'Invalid password' }
    result = @logger.log(level: 'ERROR', message: 'Error test', module_name: 'auth', error: error_info)
    log_entry = JSON.parse(result)

    assert_equal error_info.transform_keys(&:to_s), log_entry['error']
  end

  def test_empty_fields_are_omitted
    result = @logger.log(level: 'INFO', message: 'Omission test', module_name: 'test_module')
    log_entry = JSON.parse(result)

    assert_false log_entry.key?('user')
    assert_false log_entry.key?('http')
    assert_false log_entry.key?('error')
  end
end

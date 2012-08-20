require 'uri'
require 'net/https'
require 'json'

require 'noti/version'
require 'noti/request'
require 'noti/token'
require 'noti/notification'

module Noti
  class << self
    
    # Stores the application key for the application
    attr_accessor :app

  end
  
  class Error < StandardError; end
  module Errors
    class ServiceUnavailable < Error; end
    class AccessDenied < Error; end
    class NotFound < Error; end
    class CommunicationError < Error; end
    class ValidationError < Error; end
  end
  
end

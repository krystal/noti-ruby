module Noti
  class Request
  
    def self.request(path, data = {})
      req = self.new(path, :post)
      req.data = data
      req.make && req.success? ? req.output : false
    end
  
    attr_reader :path, :method, :client
    attr_accessor :data
  
    def initialize(path, method = :get)
      @path = path
      @method = method
    end
  
    def success?
      @success || false
    end
  
    def output
      @output || nil
    end
  
    def make
      uri = URI.parse(["https://notiapp.com", "api/v1", @path].join('/'))
      http_request = http_class.new(uri.request_uri)
      http_request.initialize_http_header({"User-Agent" => "NotiRubyClient/#{Noti::VERSION}"})
      http_request.content_type = 'application/json'
    
      http = Net::HTTP.new(uri.host, uri.port)
    
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    
      http_result = http.request(http_request, @data.to_json)
      if http_result.body == 'true'
        @output = true
      elsif http_result.body == 'false'
        @output = false
      else
        @output = JSON.parse(http_result.body)
      end
      @success = case http_result
      when Net::HTTPSuccess
        true
      when Net::HTTPServiceUnavailable
        raise Noti::Errors::ServiceUnavailable
      when Net::HTTPForbidden, Net::HTTPUnauthorized
        raise Noti::Errors::AccessDenied, "Access Denied for '#{Noti.app}'"
      when Net::HTTPNotFound
        json = JSON.parse(http_result.body)
        raise Noti::Errors::NotFound, json['error']
      when Net::HTTPClientError
        json = JSON.parse(http_result.body)
        raise Noti::Errors::ValidationError, json.to_s
      else
        raise Noti::Errors::CommunicationError, http_result.body
      end
      self
    end
  
    private
  
    def http_class  
      case @method
      when :post    then Net::HTTP::Post
      when :put     then Net::HTTP::Put
      when :delete  then Net::HTTP::Delete
      else
        Net::HTTP::Get
      end
    end
  
  end
end

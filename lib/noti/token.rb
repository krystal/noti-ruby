module Noti
  class Token
    
    attr_accessor :request_token, :redirect_url
    
    def self.create_request_token(redirect_url)
      request = Noti::Request.request("request_access", :app => Noti.app, :redirect_url => redirect_url)
      token = self.new
      token.request_token = request['request_token']
      token.redirect_url = request['redirect_url']
      token
    end
    
    def self.get_access_token(request_token)
      request = Noti::Request.request("get_access_token", :app => Noti.app, :request_token => request_token)
      request['access_token']
    end

    def self.revoke_access_token(user)
      Noti::Request.request("revoke", :app => Noti.app, :user => user)
    end

  end
end

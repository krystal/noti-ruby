require 'noti'
Noti.app = '7f38ce2d-8d9a-25dd-e167-8f8a711b81f8'
#token =  Noti::Token.get_request_token('http://google.com')
#puts token.redirect_url
#puts Noti::Token.get_access_token('d7801611-3fb8-f029-1870-e50bf4c327cf')
n = Noti::Notification.new
n.title = 'Blah'
n.sub_title = 'Test'
n.text = 'Blah blah blah'
n.deliver_to('9c5ce7ef-34b2-9dd4-5a78-54e9d347c606')

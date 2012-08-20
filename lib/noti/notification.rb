module Noti
  class Notification
    
    attr_accessor :title, :sub_title, :text, :sound, :url
    
    def deliver_to(user)
      data = {
        :app => Noti.app,
        :user => user,
        :notification => {
          :title => self.title,
          :sub_title => self.sub_title,
          :text => self.text,
          :url => self.url,
          :sound => self.sound
        }
      }
      Noti::Request.request('add', data) && true
    end
    
  end
end

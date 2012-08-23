module Noti
  class Notification
    
    attr_accessor :title, :text, :sound, :url, :image
    
    def deliver_to(user)
      data = {
        :app => Noti.app,
        :user => user,
        :notification => {
          :title => self.title,
          :text => self.text,
          :url => self.url,
          :sound => self.sound,
          :image => self.image
        }
      }
      Noti::Request.request('add', data) && true
    end
    
  end
end

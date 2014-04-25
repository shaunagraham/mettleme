class Message < ActsAsMessageable::Message
  self.per_page = 8
  def capitalize_title
    title.body
  end

  def self.destroy_multiple(user, ids = [])
    user.messages.process.each{|message| message.delete if ids.include?(message.id.to_s)} if !ids.nil?
  end
end
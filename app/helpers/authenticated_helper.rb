module AuthenticatedHelper
  def sidebar_list_item_link_to(text, url, options = {})
    content_tag :li, link_to(text, url, options), class: active_class_for(url, options)
  end
  
  def link_to_favorites(set)
    count = instance_variable_get("@favourite_#{set}").count
    text  = "Favorite #{set.to_s.capitalize} (#{count})"
    url   = send("#{set}_user_favorites_path")
    klass = request.path == url ? 'active show_hide1' : 'show_hide1'
    
    link_to text, url, class: klass
  end
  
  def link_to_inbox
    text  = "INBOX <span class='inbox-info'>#{@user.received_messages.count}</span>".html_safe
    url   = user_messages_path
    klass = (request.path == url) ? 'current' : ''
    
    link_to text, url, class: klass
  end
  
  def link_to_sent_messages
    text  = 'SENT'
    url   = sent_user_messages_path
    klass = (request.path == url) ? 'current' : ''
    
    link_to text, url, class: klass
  end
  
  def link_to_orders
    text  = 'My Orders'
    url   = user_orders_path
    klass = (request.path == url) ? 'current' : ''
    
    link_to text, url, class: klass
  end
  
  def link_to_current(text, path)
    link_to text, path, class: (request.path == path) ? 'current' : ''
  end
  
  private
  def active_class_for(url, options)
    'active' if request_url_matches_css_class(options[:class])
  end
  
  def request_url_matches_css_class(css_class)
    (navigation_urls[css_class] || []).include?(request.path)
  end
  
  def navigation_urls
    @navigation_urls ||= {
      'nav_pro' => [edit_user_path],
      'nav_sel' => [register_seller_user_path, edit_user_store_path],
      'nav_fav' => [products_user_favorites_path, stores_user_favorites_path],
      'nav_msg' => [user_messages_path, sent_user_messages_path],
      'nav_ord' => []
      # nav_hlp is never active, it points to a different section of the website
      # nav_log is never active, it just logs the user out
    }    
  end
end
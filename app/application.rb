class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    case
    when req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    when req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    when req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty."
      else
        @@cart.each do |item|
        resp.write "#{item}\n"
        end
      end
    when req.path.match(/add/)
      @@items.each do |item|
      pick_item = req.params["item"]
      if @@items.include?(pick_item)
          @@cart << pick_item
          resp.write "added #{pick_item}"
    else
      resp.write "We don't have that item!"
    end
    end
  end
  
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "Added #{search_term}"
    else
      return "Couldn't find #{search_term}"
    end
    end
  end

 

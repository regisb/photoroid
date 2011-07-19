module ImageHelper
  def image_html_color(name)
    # Get a fingerprint for this author in [0,1]
    x = 0
    name.each_byte{|b| x += b.to_i}
    
    # Transform this to color using a 
    # linear random number generator
    rand_a = 1664525
    rand_b = 1013904223
    r = x%256
    g = (rand_a*r + rand_b)%256
    b = (rand_a*g + rand_b)%256
    return "rgb(#{r.to_i},#{g.to_i},#{b.to_i})"
  end
end

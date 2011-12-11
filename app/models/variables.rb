class Variables < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def self.get(key)
    # If variable does not exist, create it
    var = Variables.find_by_key(key)
    if var.blank?
      var = Variables.new(:key => key, :value => create_value)
      puts "-------------------- #{key} #{value}"
      var.save
    end
    return var.value
  end

  protected
  def self.create_value
    allowed = [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    return (0...64).map{ allowed[rand(allowed.length)]  }.join
  end
end

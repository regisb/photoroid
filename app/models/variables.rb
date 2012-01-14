class Variables < ActiveRecord::Base
  validates_presence_of :key, :value
  validates_uniqueness_of :key

  def self.get(key)
    # If variable does not exist, create it
    var = Variables.find_by_key(key)
    if var.blank?
      var = Variables.new(:key => key, :value => create_value)
      puts "-------------------- #{key} #{var.value}"
      var.save
    end
    return var.value
  end

  protected
  def self.create_value
    ActiveSupport::SecureRandom.hex(64)
  end
end

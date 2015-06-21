class Item < ActiveRecord::Base

  enum status: { not_available: 0, available: 1 }

  validates_presence_of :name, :quantity, :status

  after_create :random_product_code

  has_many :bookings

  def returnable?
    self.returnable == true
  end

  def random_product_code
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    product_code = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(:code => product_code)
  end

end

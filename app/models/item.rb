class Item < ActiveRecord::Base

  enum status: { returnable: 0, not_returnable: 1 }

  validates_presence_of :name, :quantity, :status

  after_create :random_product_code

  has_many :bookings

  def is_returnable?
    status === "Returnable"
  end

  def is_not_returnable?
    status === "Not Returnable"
  end

  def random_product_code
    random = ['1'..'9'].map { |i| i.to_a }.flatten
    product_code = (0...7).map { random[rand(random.length)] }.join
    self.update_attributes(:code => product_code)
  end

end

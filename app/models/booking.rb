class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :item

  after_create :subtract_quantity

  validates_presence_of :item_id, :quantity, :start_date, :end_date, :status
  validate :available_quantity

  enum status: { open: 0, closed: 1, expired: 2 }

  after_initialize :set_default_status, :if => :new_record?

  def is_open?
    status === "Open"
  end

  def is_closed?
    status === "Closed"
  end

  def is_expired?
    status === "Expired"
  end

  def set_default_status
    self.status ||= 0
  end

  def subtract_quantity
    new_quantity = self.item.quantity - self.quantity
    self.item.update_attributes(:quantity => new_quantity)
  end

  def available_quantity
    if self.quantity > self.item.quantity && self.item.quantity != 0
      errors.add(:quantity, "You can't book more than #{self.item.quantity}")
    elsif self.item.quantity == 0
      errors.add(:quantity, "Sorry! #{self.item.name} is currently out of stock")
    end
  end

  def overdue
    if self.end_date < Time.now && !self.is_closed?
      self.update(status: 2)
    elsif self.end_date > Time.now && !self.is_closed?
      self.update(status: 0)
    end
  end

  def is_overdue?
    due_date_absolute < Time.now && self.is_expired?
  end

  def due_date_absolute
    self.end_date
  end

  def overdue_rate
    10
  end

  def fine
    overdue_rate * ((Time.now.beginning_of_day - due_date_absolute) / 1.days)
  end

end


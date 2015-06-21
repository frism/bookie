class User < ActiveRecord::Base

  has_secure_password

  validates_uniqueness_of :email

  enum status: { active: 0, suspended: 1}

  after_initialize :set_default, :if => :new_record?

  has_many :bookings

  def set_default
    self.admin ||= false
    self.status ||= "Active"
  end

  def check_status
    self.bookings.pluck(:status).include?(2) ? self.update(status: 1) : self.update(status: 0)
  end

end

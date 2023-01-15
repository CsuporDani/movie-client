class Movie < ApplicationRecord

  validates :serial, presence: true, length: { maximum: 22.bytes }, uniqueness: true
 
  before_validation :set_serial, if: -> object { object.new_record? && object.serial.blank? }

  def set_serial
    send(:serial=, SecureRandom.urlsafe_base64)
  end
end
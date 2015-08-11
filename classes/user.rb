require 'active_model'
class User
  include ActiveModel::Validations

  def initialize(*params)
    params = params.first
    params.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?("#{key}=")
    end
  end

  attr_accessor :created_at, :is_employee, :new_record

  validates :created_at, presence: true

  validate :check_types

  private
  def check_types
    errors.add(:created_at, 'should be time object') if !created_at.is_a?(Time)
    errors.add(:is_employee, 'should be either true or false') if is_employee != true && is_employee != false
    errors.add(:new_record, 'should be either true or false') if new_record != true && new_record != false
  end
end
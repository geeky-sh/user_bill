require 'active_model'
class Bill
  include ActiveModel::Validations
  LAUNDRY_TYPE = 'laundry'

  def initialize(*params)
    params = params.first
    params.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?("#{key}=")
    end
  end


  attr_accessor :amount, :type

  validates :amount, numericality: true
  validates :type, inclusion: {in: [nil, LAUNDRY_TYPE]}

  def laundry?
    type == LAUNDRY_TYPE
  end
end
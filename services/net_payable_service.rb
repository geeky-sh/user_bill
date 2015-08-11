class NetPayableService
  DIS_EMPLOYEE = Proc.new {|user, bill| bill.amount - (0.2*bill.amount).round(2)}
  NEW_USER = Proc.new {|user, bill| bill.amount - (0.1*bill.amount).round(2)}
  YEAR_OLD = Proc.new {|user, bill| bill.amount - (0.05*bill.amount).round(2)}
  GENERAL_DIS = Proc.new {|user, bill| bill.amount - ((bill.amount/100).floor*5)}
  NO_DIS = Proc.new {|user, bill| bill.amount}

  attr_accessor :user, :bill

  def initialize(user, bill)
    self.user = user
    self.bill = bill
  end

  def discounted_price
    dp = if bill.laundry?
          NO_DIS
        elsif user.is_employee == true
          DIS_EMPLOYEE
        elsif user.new_record == true
          NEW_USER
        elsif user.created_at < Time.now - (365*24*60*60)
          YEAR_OLD
        elsif bill.amount >= 100
          GENERAL_DIS
        else
          NO_DIS
        end

    dp.call(user, bill)
  end
end
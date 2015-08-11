class NetPayableService
  DIS_EMPLOYEE = Proc.new {|amt| amt - (0.2*amt).round(2)}
  NEW_USER = Proc.new {|amt| amt - (0.1*amt).round(2)}
  YEAR_OLD = Proc.new {|amt| amt - (0.05*amt).round(2)}
  GENERAL_DIS = Proc.new {|amt| amt - ((amt/100).floor*5)}
  NO_DIS = Proc.new {|amt| amt}

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

    dp.call(bill.amount)
  end
end
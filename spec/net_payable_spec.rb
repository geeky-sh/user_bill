require_relative '../classes/user'
require_relative '../classes/bill'
require_relative '../services/net_payable_service'

# require '../classes/user'
# require '../classes/bill'
# require '../services/net_payable_service'

describe NetPayableService do
  context "When the user is an employee of doormint" do
    it "should give 20% discount when the bill is not laundry" do
      user = User.new(created_at: Time.now, is_employee: true, new_record: false)
      bill = Bill.new(amount: 500, type: nil)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(400)
    end

    it "should do nothing when the bill is laundry" do
      user = User.new(created_at: Time.now, is_employee: true, new_record: false)
      bill = Bill.new(amount: 500, type: Bill::LAUNDRY_TYPE)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(bill.amount)
    end
  end

  context "When the user is the new user of doormint" do
    it "should give 10% discount on first booking" do
      user = User.new(created_at: Time.now, is_employee: false, new_record: true)
      bill = Bill.new(amount: 500, type: nil)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(450)
    end

    it "should do nothing when the bill is laundry" do
      user = User.new(created_at: Time.now, is_employee: false, new_record: true)
      bill = Bill.new(amount: 500, type: Bill::LAUNDRY_TYPE)
      expect(NetPayableService.new(user, bill).discounted_price).not_to eq(450)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(500)
    end
  end

  context "when the user is a year old" do
    it "should give 5% discount" do
      user = User.new(created_at: Time.now - (365*24*60*60*2), is_employee: false, new_record: false)
      bill = Bill.new(amount: 500, type: nil)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(475)
    end

    it "should do nothing when the bill is laundry" do
      user = User.new(created_at: Time.now - (365*24*60*60*2), is_employee: false, new_record: false)
      bill = Bill.new(amount: 500, type: Bill::LAUNDRY_TYPE)
      expect(NetPayableService.new(user, bill).discounted_price).not_to eq(475)
      expect(NetPayableService.new(user, bill).discounted_price).to eq(500)
    end
  end

  context "when the bill goes above 100 Rs." do
      it "should cut Rs. 5 for every 100 Rs." do
        user = User.new(created_at: Time.now, is_employee: false, new_record: false)
        bill = Bill.new(amount: 990, type: nil)
        expect(NetPayableService.new(user, bill).discounted_price).to eq(945)
      end

      it "should do nothing when the bill is laundry" do
        user = User.new(created_at: Time.now, is_employee: false, new_record: false)
        bill = Bill.new(amount: 990, type: Bill::LAUNDRY_TYPE)
        expect(NetPayableService.new(user, bill).discounted_price).not_to eq(945)
        expect(NetPayableService.new(user, bill).discounted_price).to eq(990)
      end
  end
end
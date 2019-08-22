require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "Validations" do
    it "valid setup?" do
      employee = Employee.new(first_name:"Henry", last_name:"Neal", rewards_balance: 500)
      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be true
      expect(errors).to be_empty
    end

    it "invalid without first?" do
      employee = Employee.new(first_name:nil, last_name:"Neal", rewards_balance: 500)
      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be false
      expect(errors).to include("First name can't be blank")
    end

    it "invalid without last?" do
      employee = Employee.new(first_name:"billy", last_name:nil, rewards_balance: 500)
      result = employee.valid?
      errors = employee.errors.full_messages

      expect(result).to be false
      expect(errors).to include("Last name can't be blank")
    end
  end

  describe "Attributes" do 
    it "has expected attributes" do
      employee = Employee.new(first_name:"Henry", last_name:"Neal", rewards_balance: 500)
      result = employee.attribute_names.map(&:to_sym) #{|name| name.to_sym}

      expect(result).to contain_exactly(
        :id,
        :first_name,
        :last_name,
        :rewards_balance,
        :created_at,
        :updated_at
      )
    end
  end

  describe "Scopes" do
    describe ".zero_balance" do
      before do
        Employee.create!([
          {first_name:"A", last_name:"Mike", rewards_balance: 0},
          {first_name:"B", last_name:"Sue", rewards_balance: 0},
          {first_name:"C", last_name:"Neal", rewards_balance: 100}
        ])
      end

      it "returns list of active records" do
        results = Employee.zero_balance

        expect(results.count).to eq 2
        expect(results.first.first_name).to eq "A"
        expect(results.last.first_name).to eq "B"
        expect(results.any? { |employee| employee.first_name == "C" }). to be false
      end
    end
  end

  describe "Instance Variables" do
    context "#full name method" do
      
      it "#fullname" do
        employee = Employee.new(first_name:"Henry", last_name:"Neal", rewards_balance: 500)
        result = employee.full_name
        expect(result.include? "Henry").to be true
        expect(result.include? "Neal").to be true
      end 
    end
    context ".can_afford" do
      employee = Employee.new(first_name:"Henry", last_name:"Neal", rewards_balance: 400)

      it "should return true on reward_cost less than or equal to 400" do 
        less_than = employee.can_afford?(321)
        equal_to = employee.can_afford?(400)

        expect(less_than).to be true
        expect(equal_to).to be true
      end

      it "should return false on reward_cost greater than 400" do
        greater_than = employee.can_afford?(432)

        expect(greater_than).to equal false
      end
    end


  end
end

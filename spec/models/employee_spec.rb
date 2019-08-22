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
  end

  describe "Scopes" do
  end

  describe "Instance Variables" do
  end
end

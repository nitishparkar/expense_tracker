require_relative '../config/sequel'
module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)
  
  class Record
    def initialize(expense_id, payee, amount)
      @expense_id = expense_id
      @payee = payee 
      @amount = amount
    end

    def to_h
      {
        expense_id: @expense_id,
        payee: @payee,
        amount: @amount
      }
    end
  end

  class Ledger
    def record(expense)
      unless expense.key?('payee')
        message = 'Invalid expense: `payee` is required'
        return RecordResult.new(false, nil, message) 
      end

      DB[:expenses].insert(expense) 
      id = DB[:expenses].max(:id) 
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end
  end 
end
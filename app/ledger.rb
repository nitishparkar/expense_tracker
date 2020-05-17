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
    end

    def expenses_on(date)
    end
  end 
end
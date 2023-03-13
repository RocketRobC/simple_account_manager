module AccountManager
  class CustomerAccount
    attr_accessor :account_number, :balance

    def initialize(account_number:, balance:)
      @account_number = account_number
      @balance = Float(balance)
    end

    def credit(amount)
      if balance + amount > 0
        self.balance += amount
      end
    end

    def debit(amount)
      if balance >= amount
        self.balance -= amount
      end
    end
  end
end

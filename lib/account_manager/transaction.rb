module AccountManager
  class Transaction
    attr_reader :from_account, :to_account, :amount

    def initialize(from_account:, to_account:, amount:)
      @from_account = from_account
      @to_account = to_account
      @amount = Float(amount)
    end
  end
end

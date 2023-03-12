module AccountManager
  class FundsError < StandardError; end

  class Transactor < CallableService
    attr_reader :transaction

    def initialize(transaction)
      @transaction = transaction
    end

    def call
      if transaction.from_account.debit(transaction.amount)
        transaction.to_account.credit(transaction.amount)
      else
        raise FundsError, "Insufficient funds. " +
          "From Acc: #{transaction.from_account.account_number}. " +
          "To Acc: #{transaction.to_account.account_number}. " +
          "Amount Requested: $%.2f" % transaction.amount
      end
    end
  end
end

module AccountManager
  class FundsError < StandardError; end

  class Transactor < CallableService
    attr_reader :transaction

    def initialize(transaction)
      @transaction = transaction
    end

    def call
      (transaction.source_account.debit(transaction.amount) &&
          transaction.target_account.credit(transaction.amount)) ||
            raise_insufficient_funds
    end

    private

    def raise_insufficient_funds
      raise FundsError, "Insufficient funds. " +
        "From Acc: #{transaction.source_account.account_number}. " +
        "To Acc: #{transaction.target_account.account_number}. " +
        "Amount Requested: $%.2f" % transaction.amount
    end
  end
end

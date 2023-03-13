module AccountManager
  class Transaction
    attr_reader :source_account, :target_account, :amount

    def initialize(source_account:, target_account:, amount:)
      @source_account = source_account
      @target_account = target_account
      @amount = Float(amount)
    end
  end
end

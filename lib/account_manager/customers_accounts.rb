module AccountManager
  class AccountValidationError < StandardError; end
  class AccountLookupError < StandardError; end

  class CustomersAccounts
    attr_reader :ledger

    def initialize
      @ledger = {}
    end

    def find(acc_no)
      ledger.fetch(acc_no)
    rescue KeyError
      raise AccountLookupError, "Unable to find account #{acc_no}" 
    end

    def add_account(account)
      if ledger.keys.include?(account.account_number)
        raise AccountValidationError, "Duplicate account number: #{account.account_number}"
      else
        @ledger[account.account_number] = account
      end
    end
  end
end

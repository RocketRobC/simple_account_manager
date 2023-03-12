require 'csv'

module AccountManager
  class App
    def initialize(transaction_data:, account_balances:, view:)
      @transaction_data = transaction_data
      @account_balances = account_balances
      @view = view
      @accounts = CustomersAccounts.new
    end

    def run
      create_accounts
      view.render_balance(accounts)
      process_transactions
      view.render_balance(accounts)
    end

    private

    attr_reader :transaction_data, :account_balances, :view
    attr_accessor :accounts

    def create_accounts
      CSV.foreach(account_balances) do |row|
        new_account = AccountManager::CustomerAccount.new(
          account_number: row[0],
          balance: row[1]
        )
        accounts.add_account(new_account)
      rescue => e
        view.render_error(e)
      end
    end

    def process_transactions
      CSV.foreach(transaction_data) do |row|
        transaction = AccountManager::Transaction.new(
          from_account: accounts.find(row[0]),
          to_account: accounts.find(row[1]),
          amount: row[2]
        )
        AccountManager::Transactor.call(transaction)
      rescue => e
        view.render_error(e)
      end
    end
  end
end

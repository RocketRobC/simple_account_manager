require 'csv'

module AccountManager
  class App
    def initialize(transaction_data:, account_balances:, view:)
      @transaction_data = transaction_data
      @account_balances = account_balances
      @view = view
    end

    def run
      openning_balances = create_openning_accounts
      closing_balances = process_transactions(copy_accounts(openning_balances))
      view.render_openning_closing(openning_balances, closing_balances)
    end

    private

    attr_reader :transaction_data, :account_balances, :view

    def create_openning_accounts
      accounts = CustomersAccounts.new
      CSV.foreach(account_balances) do |row|
        new_account = CustomerAccount.new(
          account_number: row[0],
          balance: row[1]
        )
        accounts.add_account(new_account)
      rescue => e
        view.render_error(e)
      end
      accounts
    end

    def process_transactions(balances)
      CSV.foreach(transaction_data) do |row|
        transaction = Transaction.new(
          from_account: balances.find(row[0]),
          to_account: balances.find(row[1]),
          amount: row[2]
        )
        Transactor.call(transaction)
      rescue => e
        view.render_error(e)
      end
      balances
    end

    def copy_accounts(accounts)
      accounts.ledger.each_with_object(CustomersAccounts.new) do |(num, acc), new_accounts|
        acc = CustomerAccount.new(
          account_number: num,
          balance: acc.balance
        )
        new_accounts.add_account(acc)
      end
    end
  end
end

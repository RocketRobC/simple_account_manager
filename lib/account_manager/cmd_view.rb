module AccountManager
  class CmdView
    def render_error(error)
      puts error.message
    end

    def render_balance(accounts)
      puts 'Current Account Ledger'
      puts '----------------------'
      accounts.ledger.each do |k, entry|
        puts entry.account_number.ljust(18) + '|' +  format_money(entry.balance.round(2)).rjust(11)
      end
    end

    private

    def format_money(number)
      '$' + '%.2f' % number
    end
  end
end

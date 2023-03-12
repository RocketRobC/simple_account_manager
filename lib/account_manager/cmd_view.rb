module AccountManager
  class CmdView
    def render_error(error)
      puts error.message
    end

    def render_openning_closing(openning, closing)
      puts 'Daily Openning and Closing'
      puts '--------------------------'
      puts 'Account'.ljust(18) + '|' + 'Openning'.rjust(11) + ' |' + 'Closing'.rjust(11)
      merged_balances(openning, closing).each do |acc_no, entry|
        puts acc_no.ljust(18) + '|' + format_money(entry[0]).rjust(11) + ' |' + format_money(entry[1]).rjust(11)
      end
      puts "\n"
    end

    private

    def merged_balances(openning, closing)
      openning.ledger.each_with_object({}) do |(num, acc), hash|
        hash[num] = [acc.balance, closing.ledger[num].balance]
      end
    end

    def format_money(number)
      '$' + '%.2f' % number
    end
  end
end

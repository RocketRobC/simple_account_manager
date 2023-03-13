require 'spec_helper'

module AccountManager
  class TestView
    def render_with_errors(errors, *_args)
      errors.map(&:message)
    end

    def render_openning_closing(openning, closing)
      openning.ledger.each_with_object({}) do |(num, acc), hash|
        hash[num] = [acc.balance, closing.ledger[num].balance]
      end
    end
  end

  describe App do
    let(:view) { TestView.new }
    let(:openning_balances) do
      [['123', '100'], ['456', '200']]
    end
    let(:transaction_data) do
      [['123', '456', '50'], ['456', '123', '100']]
    end

    def generate_csv(data, name)
      file = StringIO.new(name).string
      csv = CSV.open(file, 'w') do |csv|
        data.each { |row| csv << row }
      end
      file
    end

    subject do
      App.new(
        transaction_data: generate_csv(transaction_data, './tmp/trans'),
        account_balances: generate_csv(openning_balances, './tmp/bals'),
        view: view
      )
    end

    it 'calculates the closing balance' do
      expect(subject.run).to eq({"123"=>[100.0, 150.0], "456"=>[200.0, 150.0]})
    end

    context 'with invalid data' do
      context 'for account number' do
        let(:transaction_data) do
          [['666', '456', '50'], ['456', '123', '100']]
        end

        it 'returns an error' do
          expect(subject.run).to include('Unable to find account 666')
        end
      end

      context 'for insufficient funds' do
        let(:openning_balances) do
          [['123', '10'], ['456', '200']]
        end

        it 'returns an error' do
          expect(subject.run).to include <<~EOM.chomp
          Insufficient funds. From Acc: 123. To Acc: 456. Amount Requested: $50.00
          EOM
        end
      end

      context 'for duplicate accounts' do
        let(:openning_balances) do
          [['123', '100'], ['123', '200']]
        end

        it 'returns an error' do
          expect(subject.run).to include('Duplicate account number: 123')
        end
      end
    end
  end
end

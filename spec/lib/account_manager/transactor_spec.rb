require 'spec_helper'

module AccountManager
  describe Transactor do
    let(:from_account) { CustomerAccount.new(account_number: '123', balance: '50') }
    let(:to_account) { CustomerAccount.new(account_number: '345', balance: '100') }
    let(:transaction) do
      Transaction.new(
        from_account: from_account,
        to_account: to_account,
        amount: amount
      )
    end
    let(:amount) { 10 }

    subject { Transactor.new(transaction) }

    it 'transfers funds' do
      expect { subject.call }.to change { from_account.balance }.from(50).to(40).
        and change { to_account.balance }.from(100).to(110)
    end

    context 'with insufficient debit funds' do
      let(:from_account) { CustomerAccount.new(account_number: '123', balance: '9') }

      it 'raises an error' do
        expect { subject.call }.to raise_error FundsError
      end
    end
  end
end

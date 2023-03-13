require 'spec_helper'

module AccountManager
  describe Transactor do
    let(:source_account) { CustomerAccount.new(account_number: '123', balance: '50') }
    let(:target_account) { CustomerAccount.new(account_number: '345', balance: '100') }
    let(:transaction) do
      Transaction.new(
        source_account: source_account,
        target_account: target_account,
        amount: amount
      )
    end
    let(:amount) { 10 }

    subject { Transactor.new(transaction) }

    it 'transfers funds' do
      expect { subject.call }.to change { source_account.balance }.from(50).to(40).
        and change { target_account.balance }.from(100).to(110)
    end

    context 'with insufficient debit funds' do
      let(:source_account) { CustomerAccount.new(account_number: '123', balance: '9') }

      it 'raises an error' do
        expect { subject.call }.to raise_error FundsError
      end
    end

    context 'when crediting a negaitve amount' do
      let(:amount) { -101 }

      it 'raises an error if the account fall below 0' do
        expect { subject.call }.to raise_error FundsError
      end
    end
  end
end

require 'spec_helper'

module AccountManager
  describe CustomerAccount do
    subject { CustomerAccount.new(account_number: '12345', balance: '50.0') }
  
    context 'crediting the account' do
      it 'credits the account' do
        expect(subject.credit(10)).to eq 60.0
      end

      it 'returns nil if crediting a negative amount falls below 0' do
        expect(subject.credit(-60)).to eq nil
      end
    end
  
    context 'debiting the account' do
      it 'debits the account' do
        expect(subject.debit(10)).to eq 40.0
      end

      it 'returns nil for insufficient funds' do
        expect(subject.debit(60)).to eq nil
      end
    end
  end
end

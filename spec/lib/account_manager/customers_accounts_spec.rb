require 'spec_helper'

module AccountManager
  describe CustomersAccounts do
    let(:acc_1) { CustomerAccount.new(account_number: '123', balance: '50') }
    let(:acc_2) { CustomerAccount.new(account_number: '456', balance: '100') }

    subject { CustomersAccounts.new }

    context 'finding an account' do
      before(:each) do
        subject.add_account(acc_1)
        subject.add_account(acc_2)
      end

      it 'is successfull' do
        expect(subject.find('456')).to eq acc_2
      end

      it 'raises an error if not found' do
        expect { subject.find('666') }.to raise_error AccountLookupError
      end
    end

    context 'adding an account' do
      it 'is successfull' do
        expect { subject.add_account(acc_1) }.to change { subject.ledger }
        expect(subject.ledger).to include({ '123' => acc_1 })
      end

      it 'raises an error if the account already exists' do
        subject.add_account(acc_1)
        expect { subject.add_account(acc_1) }.to raise_error AccountValidationError
      end
    end
  end
end

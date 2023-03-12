# Account Manager

## Outline

You are a developer for a company that runs a very simple bankig service. Each
day companies provide you with a CSV file of transfers they want to make between
accounts for customers they are doing business with. 

Accounts are identified by a 16 digit number and **money cannot be transferred
from then if it will put the account balance below $0**.

This application loads a list of account balances for a single company and
accepts a day's transfers as a CSV file returning the new account balances for
the day. 

## Installation

Run `bundle install` to install all dependencies.

## Operation

The application can be run from the command line and accepts one argument of the
path to the day's transactions CSV.

```
$ bin/run.rb <path to CSV>
```

The application with return the current daily balances to the command line.

```
Current Account Ledger
----------------------
1111234522226789  |    $720.50
1111234522221234  |   $9974.40
2222123433331212  |   $1550.00
1212343433335665  |   $1225.60
3212343433335755  |  $48679.50
```

## Assumptions

### Transactions

The provided list of transactions are processed sequentially and if a
transactions is not able to be performed, it's because at that point in time it
was not possible to execute the transaction due to insufficient funds.

### CSV Data

The provided CSV have no header information. 

Account columns:
[0] - Account Number
[1] - Openning Balance

Transaction columns:
[0] - from account
[1] - to account
[2] - amount

## Testing

Tests have been written using RSpec. Run `bundle exec rspec spec` to run the tests.

# Account Manager

## Outline

You are a developer for a company that runs a very simple bankig service. Each
day companies provide you with a CSV file of transfers they want to make between
accounts for customers they are doing business with. 

Accounts are identified by a 16 digit number and **money cannot be transferred
from them if it will put the account balance below $0**.

This application loads a list of account balances for a single company and
accepts a day's transfers as a CSV file returning the new account balances for
the day. 

## Installation

Run `bundle install` to install all dependencies.

## Operation

The application can be run from the command line and accepts one argument of the
path to the day's transactions CSV.

```
$ bin/run <path to CSV>
```

The application with return the daily openning and closing balances of each account to the command line.

```
Daily Openning and Closing
--------------------------
Account           |   Openning |    Closing
1111234522226789  |   $5000.00 |   $4820.50
1111234522221234  |  $10000.00 |   $9974.40
2222123433331212  |    $550.00 |   $1550.00
1212343433335665  |   $1200.00 |   $1725.60
3212343433335755  |  $50000.00 |  $48679.50
```

## Assumptions

### Transactions

The provided list of transactions are intended to be processed sequentially and if a
transactions is not able to be performed, it's because at that point in time it
was not possible to execute the transaction due to an error.

If a single transaction is not able to be performed because of insufficient funds or
the source or target accounts do not exist, then the remaining transactions will continue to be
processed. In this case the errors will be shown along with the openning and
closing balance for the transactions that were executed.

If the entered transaction amount is a negative value the transaction will
be processed. However if the target account balance would drop below $0 as a result of
the transaction, it won't be completed and an error an will be returned.

### CSV Data

The provided CSV's have no header information and the following column indexes
have been used. 

Account columns:

- [0] - Account Number
- [1] - Openning Balance

Transaction columns:

- [0] - source account
- [1] - target account
- [2] - amount

## Testing

Tests have been written using RSpec. Run `bundle exec rspec spec` to run the tests.

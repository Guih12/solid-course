require_relative 'bank_account'


bank = BankAccount.new

bank.deposit(100)

bank.withdraw(100, "123")
bank.withdraw(100, "123")

bank.statement("123")
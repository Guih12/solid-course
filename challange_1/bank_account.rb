class BankAccount
  def initialize()
    @pin             = "123"
    @balance         = 0
    @overdraft_limit = 100
    @transactions    = []
  end

  def deposit(amount)
    @balance += amount

    @transactions << { type: "credit", amount: amount, balance: @balance, recorded_at: Time.now }

    display_balance
  end


  def withdraw(amount, pin)
    return pin_message_error unless verify_pin(pin)

    return 'Insufficient funds!' if (@balance +  @overdraft_limit) < amount

    @balance -= amount

    @transactions << { type: "debit", amount: amount, balance: @balance, recorded_at: Time.now }

    display_new_balance(amount)
  end

  def statement(pin)
    return pin_message_error unless verify_pin(pin)

    display_balance
  end

  private

  def display_balance
    rows = []

    @transactions.each do |value|
      rows << (
        "#{value[:recorded_at].strftime("%Y-%m-%d")} |" + 
        "#{value[:type]} | " + 
        "#{value[:amount]} | " + 
        "#{value[:amount]} | "
      )
    end

    puts "date      | type | amount | balance", rows
  end

  def display_new_balance(amount)
    puts "Withdraw: #{amount} | New Balance: #{@balance}"
  end


  def verify_pin(pin)
    @pin == pin
  end

  def pin_message_error
   puts "Invalid Pin. Access Danied"
  end
end
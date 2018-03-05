class Transfer
  attr_reader :sender, :receiver, :amount, :status

  def initialize(from_acct, to_acct, amount)
    @sender = from_acct
    @receiver = to_acct
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if !@sender.valid? || @sender.balance < @amount
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    elsif status == 'pending'
      @sender.balance -= amount
      @receiver.balance += amount
      @status = 'complete'
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end

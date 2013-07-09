module StatementsHelper

  def stringifyAmount(statements)
    statements.each do |statement| 
      statement.amount = statement.amount.round(2).to_s 
    end
  end
end

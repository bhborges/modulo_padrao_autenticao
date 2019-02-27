Float.class_eval do
  def to_currency
    Money.new(('%.2f' % self).to_s.delete('.'), 'BRL').format(symbol: '')
  end

  def to_money
    Money.new(('%.2f' % self).to_s.delete('.'), 'BRL').format
  end
end

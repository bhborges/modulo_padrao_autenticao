class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  cattr_accessor :search_scopes do
    []
  end

  def self.add_scope(name, &block)
    singleton_class.send(:define_method, name.to_sym) do |*args|
      block.call(*args) || all
    end
    search_scopes << name.to_sym
  end

  def helpers
    ActionController::Base.helpers
  end

  def to_a
    [self]
  end
end

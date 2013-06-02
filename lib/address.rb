#coding: UTF-8
class Address

  @@addresses = Array.new

  attr_accessor :name, :index

  def initialize(name)
    raise "Ошибка: кончилось адресное пространство" if @@addresses.size > 200
    @name = name
    @@addresses << self
  end

  def index
    @@addresses.index(self)
  end

  def self.all
    @@addresses
  end

  def self.find(op)
    self.all.each do |address|
        if op.str == address.name
          return address
        end
    end
    nil
  end

  def self.find_by_name(name)
    self.all.each do |address|
        if name == address.name
          return address
        end
    end
    nil
  end

  def self.find_or_create(op)
    address = find(op)
    if address
      address
    else
      Address.new(op.str)
    end
  end

end

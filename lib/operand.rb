#coding: UTF-8
class Operand

  @@types = [:direct, :straight, :register, :indirect]

  attr_accessor :address, :str

  def initialize(str, value = nil)
    @str = str
    @address = Address.find_or_create(self)
  end

  def double_type
    res = nil
    @@types.each_with_index do |type, index|
      res = index.to_s(2) if is_a?(type)
    end
    "0"*(2-res.size) + res
  end

  def type
    @@types.each_with_index do |type, index|
      return type if is_a?(type)
    end
  end

  #def address
    #@address.index
  #end

  def double_value
    res = case type
          when :direct
            @str.to_i.to_s(2)
          when :straight
            @str.gsub('#', '').to_i.to_s(2)
          when :register
            self.address.index.to_s(2)
          when :indirect
            Address.find_by_name(self.address.name[/\w/]).index.to_s(2)
            #Address.find(self).value.to_i.to_s(2)
          end
    "0"*(12-res.size) + res
  end

  def is_a?(sym_type)
    case sym_type
    when :direct
      return true if @str[/^\d*$/]
    when :indirect
      return true if @str[/^\([a-z]\)$/]
    when :straight
      return true if @str[/^\#\d*$/]
    when :register
      return true if @str[/^[a-z]$/]
    end
  end

end

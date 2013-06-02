#coding: UTF-8
class Command
  def initialize(str)
    @str = str
    case type
    when :binar
      @op1, @op2 = Operand.new(str[get_op1]), Operand.new(str[get_op2])
    when :unar
      @op1 = Operand.new(str[get_op1])
    end
  end

  def full_code
    send(type)
    # type => :binar || :unar || :without_oper
  end

  def code
    res = if @str[/^add#{binar_regexp}$/]
            0
          elsif @str[/^sub#{binar_regexp}$/]
            1
          elsif @str[/^div#{binar_regexp}$/]
            2
          elsif @str[/^mul#{binar_regexp}$/]
            3
          elsif @str[/^and#{binar_regexp}$/]
            4
          elsif @str[/^or#{binar_regexp}$/]
            5
          elsif @str[/^mov#{binar_regexp}$/]
            6
          elsif @str[/^shr#{unar_regexp}$/]
            7
          elsif @str[/^shl#{unar_regexp}$/]
            8
          elsif @str[/^jz#{binar_regexp}$/]
            9
          elsif @str[/^jn#{binar_regexp}$/]
            10
          elsif @str[/^jmp#{unar_regexp}$/]
            11
          elsif @str[/^inc#{unar_regexp}$/]
            12
          elsif @str[/^dec#{unar_regexp}$/]
            13
          elsif @str[/^stop\s*$/]
            14
          elsif @str[/^not#{unar_regexp}$/]
            15
          else
            raise "Ошибка: Некоректная команда в строке #{Runner.line}."
          end
    res = res.to_s(2)
    '0'*(4 - res.size) << res
  end


  def type
    if @str[binar_regexp]
      :binar
    elsif @str[unar_regexp]
      :unar
    else
      :without_oper
    end
  end

  private


  def get_op1
    @str.split(',')[0].split(' ')[1].strip
  end

  def get_op2
    @str.split(',')[1].strip
  end

  def unar_regexp
    /#{address_regexp}/
  end

  def binar_regexp
    /#{address_regexp},#{address_regexp}/
  end

  def address_regexp
    /\s+(\(\w*\)|#\w*|\w*)\s*/
  end

  def binar
    self.code << @op1.double_type << @op1.double_value << @op2.double_type << @op2.double_value
  end

  def unar
    self.code << @op1.double_type << @op1.double_value << "0"*2 << "0"*12
  end

  def without_oper
    self.code << "0"*28
  end

end

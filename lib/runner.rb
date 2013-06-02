class Runner
  @@line = 0
  def self.start
    code_rows = File.read('sample.code').split("\n")
    result = File.open("result.bin", "w+")
    code_rows.each do |row|
      result.puts(Command.new(row).full_code << "\n")
      @@line += 1
    end
    result.close
  end

  def self.line
    @@line
  end

end

#!/usr/bin/env ruby
# reverse polish anotation program

class StackCalc
  def initialize(interactive = true)
    @interactive = interactive
    @stack = []
  end

  def error(message)
    message = "ERROR: #{message}"
    if @interactive
      $stderr.puts message
    else
      raise message
    end
  end

  def push(x)
    unless x =~ /^[0-9]+$/ # unless it is numerical string it is thrown a way
      puts "ERROR: Not a number"
      return
    end
    @stack << x.to_i
  end

  def swap
    unless @stack.count >= 2
      puts "ERROR: Not enough operants"
    end
    a = @stack.pop
    b = @stack.pop
    @stack << a
    @stack << b
  end

  def add
    unless @stack.count >= 2
      puts "ERROR: Not enough operants"
    end
    a = @stack.pop
    b = @stack.pop
    @stack << a + b
  end

  def minus
    unless @stack.count >= 2
      puts "ERROR: Not enough operants"
    end
    b = @stack.pop
    a = @stack.pop
    @stack << a - b
  end

  def multiply
    unless @stack.count >= 2
      puts "ERROR: Not enough operants"
    end
    a = @stack.pop
    b = @stack.pop
    @stack << a * b
  end

  def divide
    unless @stack.count >= 2
      puts "ERROR: Not enough operants"
    end
    b = @stack.pop
    a = @stack.pop
    @stack << a / b
  end

  def pop
    @stack.pop
  end

  def print
    @stack.each { |e| puts e }
  end

  def exit_out_of_program
    exit
  end

  def clear_screen
#    puts "\e[H\e[2J"
    system("clear") 
  end

  def menu
    puts "Options: +, -, /, *, swap, pop, print, exit, clear, menu"
  end
end

interactive = $stdin.tty?
stack = StackCalc.new(interactive)

loop do
  print "> " if interactive
  line = $stdin.readline.chomp # global variable
  case line
  when '+'
    stack.add
  when '-'
    stack.minus
  when '/'
    stack.divide
  when '*'
    stack.multiply
  when 'clear'
    stack.clear_screen
  when 'swap'
    stack.swap
  when 'pop'
    stack.pop
  when 'print'
    stack.print
  when 'exit'
    stack.exit_out_of_program
  when 'menu'
    stack.menu
  when ''
    next
  else
    stack.push line
  end
rescue EOFError
  break
end

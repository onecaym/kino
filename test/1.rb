class A
  define_singleton_method :loudly do |message|
    puts message.upcase
  end
end

puts A.loudly 'gg'

Pry::Commands.block_command "callera", "Filter the caller backtrace" do
  output = caller.reject! { |line| line["pry"] } 
  puts "\e[31m#{output.join("\n")}\e[0m"
end

Pry::Commands.block_command "callerf", "Filter the caller backtrace" do
  output = caller.select { |line| line.include? "Envoy" } 
  puts "\e[31m#{output.join("\n")}\e[0m"
end

require "os"
require "colorize"
require "net/http"
require "json"

def clear_terminal
    if OS.windows?
        system("cls")
    else
        system("clear")
    end
end

clear_terminal

finished = false

while !(finished) 
    print "CFX code: "
    cfx_code = gets.chomp

    if cfx_code.include? "/join/"
        cfx_code = cfx_code.split("/join/")[1]
    end

    clear_terminal

    uri = URI("https://servers-frontend.fivem.net/api/servers/single/#{cfx_code}")
    response = Net::HTTP.get_response(uri)

    if response.code == "404"
        puts "Invalid code!".red
        next
    end
    data = JSON.parse(response.body)

    print "IP:PORT = ".green
    puts data["Data"]["connectEndPoints"][0]

    print "Nova consulta? (Y/n) ".blue
    resposta = gets.chomp

    if resposta.downcase == "y"
        next
    elsif resposta.downcase == "n"
        finished = true
    else
        next
    end
end

clear_terminal
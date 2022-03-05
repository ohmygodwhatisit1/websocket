# frozen_string_literal: true

require 'websocket-eventmachine-client'
require 'eventmachine'
require 'optparse'
require 'ostruct'

options = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-s', '--server SERVER', 'Адрес сервера') { |o| options.server = o }
  opt.on('-f', '--file FILE', 'Текстовый файл') { |o| options.file = o }
end.parse!

if options.to_s == '#<OpenStruct>'
  puts 'Отсутствуют аргументы'
  exit
end

if options.server.to_s.nil?
  puts 'Отсутствует адрес сервера'
  exit
end

if options.file.to_s.nil?
  puts 'Файл отсутствует'
  exit
end

exit 'Неправильный адрес сервера' unless options.server.include? 'ws://'

exit 'Нетекстовый файл' unless options.file.split('.')[1] == 'txt'

EM.run do
  ws = WebSocket::EventMachine::Client.connect(uri: options.server)

  ws.onopen do
    puts "Клиент подключен к серверу #{options.server}"
  end

  ws.onmessage do |msg, _type|
    puts "Полученное сообщение: #{msg}"
  end

  EventMachine.next_tick do
    msg = File.read(options.file)

    ws.send msg
  end

  ws.onclose do |code, _reason|
    puts "Сервер отключен с кодом #{code}"
  end
end
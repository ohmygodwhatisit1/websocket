## Где скачать Ruby?
[Тут](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.1.1-1/rubyinstaller-devkit-3.1.1-1-x64.exe)
## Как пользоваться
В папке с программой открыть консоль и ввести

    bundle install
    ruby client.rb -s SERVER -f FILE

Например:

    ruby client.rb -s ws://0.0.0.0:8084 -f test.txt

require "optparse"
require "shell_help/version"

module ShellHelp
  # Your code goes here...
  class Command
    def self.run(argv=[])
      new(argv).execute
    end
    
    def initialize(argv=[])
      @argv=argv
      data_path = File.join(ENV['HOME'],'.hikirc')
    end
    
    def execute
      command_parser = OptionParser.new do |opt|
        opt.on('-v','--version','          バージョンの表示') { |v|
          opt.version = ShellHelp::VERSION
          puts opt.ver
        }
        opt.on('-d','--ディレクトリ','    ディレクトリ操作') {dir}
        opt.on('-f','--ファイル','      ファイル操作') {file}
        opt.on('-b','--ファイル,ディレクトリ','ファイル，ディレクトリ操作') {both}
        opt.on('-o','--その他','       その他') {other}
      end
      begin
        command_parser.parse!(@argv)
      rescue=> eval
        p eval
      end
      exit
    end
    
    def disp(lines)
      lines.each{|line|
        if line.include?(',')
          show line
        else
          puts line
        end
      }
    end
    def show(line)
      puts "#{line}"
    end

    def dir
      cont=[ "pwd(print working directory)：作業ディレクトリを表示",
             "cd(change directory)：作業ディレクトリを移動",
             "ls(list)：ファイルやディレクトリを表示",
             "rmdir(remove directory) [オプション] [削除したいディレクトリ名]：ディレクトリを削除",
             "mkdir(make directory) [オプション] [作成ディレクトリ名]：ディレクトリを作成"]
      disp(cont)
    end

    def file
      cont=[ "mv(move) [オプション] [変更前ファイル名・ディレクトリ名]：ファイルの移動，ファイル名の変更",
             "cp(copy) [オプション] [コピー元ファイル名・ディレクトリ名] [コピー先ファイル名・ディレクトリ名]：ファイルをコピー",
             "rm(remove) [オプション] [削除したいファイル名・ディレクトリ名]：ファイルを削除",
             "touch [オプション] [変更ファイル名・ディレクトリ名]：ファイルの更新日時を更新",
             "cat(catenate) [オプション] [閲覧したいファイル名]：ディレクトリを閲覧",
             "more,less [オプション] [閲覧したいファイル]：ファイルをページ単位で閲覧"]
      disp(cont)
    end
    
    def other
      cont=[ "grep [オプション] [文字列パターン] [ファイル名]：文字列を検索",
             "[コマンド名] > [ファイル名]：標準出力をファイルに書き込む",
             "[コマンド名] >> [ファイル名]：標準出力をファイルに追加",
             "[コマンド名] < [ファイル名]：標準入力を読み込む",
             "emacs [ファイル名]：emacsエディタ",
             "ruby [オプション] [ファイル名]：Rubyの使用",
             "ps [オプション]：起動しているプロセスを表示したい",
             "sudo [オプション] [ファイル名]：他のユーザとしてコマンドを実行したい",
             "source [オプション] [ファイル名]：シェルの設定ファイルを読み込む",
             "diff [オプション] [ファイル名1・ディレクトリ名1] [ファイル名2・ディレクトリ名2]：二つのファイルの内容の違いを調べたい"]
      disp(cont)
    end
    
    def both
      cont=[ "chmod(change mode) [オプション] [権限] [ファイル名・ディレクトリ名]:ファイル権限を変更",
             "chown(change owner) [オプション] [所有者名] [ファイル名・ディレクトリ名]：ファイルの所有者を変更"]
      disp(cont)
    end

  end

end

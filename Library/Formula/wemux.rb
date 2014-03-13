require 'formula'

class Wemux < Formula
  homepage 'https://github.com/zolrath/wemux'
  url 'https://github.com/downloads/zolrath/wemux/wemux-3.2.0.tar.gz'
  sha1 '099e6afbd5313aadd9a4dae7fc416f3846888624'

  head 'https://github.com/zolrath/wemux.git'

  depends_on 'tmux'

  def install
    inreplace 'wemux', '/usr/local/etc', etc
    bin.install 'wemux'
    man1.install 'man/wemux.1'

    inreplace 'wemux.conf.example', 'change_this', ENV['USER']
    etc.install 'wemux.conf.example' => 'wemux.conf'
  end

  def caveats; <<-EOS.undent
    Your current user account has been automatically added as a wemux host.

    To give a user the ability to host wemux sessions add them to the
    host_list array in:
      #{etc}/wemux.conf

    Either edit the file in your text editor of choice or run `wemux conf` to
    open the file in your $EDITOR.
    EOS
  end

  test do
    system "#{bin}/wemux", "help"
  end
end

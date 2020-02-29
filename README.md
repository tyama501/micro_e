# micro_e
以前FreeBASICで作成していたものを元に
試験的にPC-98版 EL_BASICへ移植/改変を行っています。

以下で公開されているEL_BASIC 98版を使用しています。
<br>
https://www.vector.co.jp/soft/dos/prog/se008573.html

FreeDOS(98)+Neko Project 21/W環境で試しています。

## コンパイルと実行方法
コンパイル  
ELBAS98 MICROE.BAS
<br>
実行  
RUN98 MICROE.ELB 

<br>
Shift_JISの文字コードがあるため
ブラウザでは化けて見えるかもしれません。
<br>
localにiconvがある場合、
以下をgitconfigに追加するとdiffでは
正しく読めるかもしれません。
<br>
[core]
<br>
        pager = LC_ALL=ja_JP.UTF-8 less
<br>        
[diff "cp932"]
<br>
        textconv = iconv -f cp932 -t utf-8

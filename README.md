# micro_e
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

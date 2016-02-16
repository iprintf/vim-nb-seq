# vim-nb-seq

对指定行范围自动加前缀递增数

安装:
    mkdir ~/.vim/plugin -p
    cp seq.vim ~/.vim/plugin/

    也可以使用bundle来管理

用法:
    :[line1,line2]Seq [start] [step] [format]
        line1  指定起始行 默认为第一行
        line2  指定结束行 默认为最后一行
        start  指定数字编辑起始数, 默认值为1
        step   步长
        format 前缀格式(printf的%d样式)
            支持的格式：(具体使用参考printf，你懂的)
                %d %10d %-10d %010d

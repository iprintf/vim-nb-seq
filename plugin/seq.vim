" seq.vim - long zhu (iprintf.com)
"
" shell seq command for VIM.
"
" 完成陈仲林提出自动加递增数前缀需要
"
"Usage:
" :[line1,line2]nbseq [start] [step] [format]
"    line1  指定起始行
"    line2  指定结束行
"    start  指定数字编辑起始数, 默认值为1
"    step   步长
"    format 前缀格式(printf的%d样式)
"
"
function! KyoNBArgs(args)
    let err = ['请输入起始行', '请输入结束行']
    let def = [1, 1, '%d']
    let ret = []
    let i = 0

    for v in a:args
        if v
            if i < 2
                echo '错误: '.err[i].'!'
                return 0
            else
                ret[i] = def[i - 2]
            endif
        else
            ret[i] = v
        endif
        let i = i + 1
    endfor

    return ret
endfunction


function! KyoNBSeq(...)
"{
    let opt = KyoNBArgs(a:000)

    if opt == 0
        return 1
    endif

    return 0
"}
endfunction

command! -range -nargs=* Seq call KyoNBSeq(<line1>, <f-args>)

" seq.vim - long zhu (iprintf.com)
"
" shell seq command for VIM.
"
" 完成陈仲林提出自动加递增数前缀需求
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
    let ret = [1, 1, '%d ']
    let l = len(a:args)

    " echo a:args
    " echo ' l = '.l

    if l > 0
        let ret[0] = a:args[0]
    endif

    if l > 1
        let ret[1] = a:args[1]
    endif

    if l > 2
        let ret[2] = ''
        let e = l - 1
        for i in range(2, e)
            let ret[2] = ret[2].a:args[i]
        endfor
    endif

    return ret
endfunction

function! KyoNBFormat(string, num)
    let s = stridx(a:string, '%')
    let e = stridx(a:string, 'd', s)

    "%d 如果光是%d直接替换退出
    if s + 1 == e
        return substitute(a:string, '%d', a:num, 'g')
    endif

    "获取%d之间格式
    let format = strpart(a:string, s + 1, e)

    "%-3d
    "%-03d
    "%-03d 获取负号 前缀零 以及对齐数
    let sym = strpart(format, 0, 1)
    if sym == '-'
        let zero = strpart(format, 1, 1)
        let align = str2nr(strpart(format, 1)) - len(a:num)
    else
        let zero = strpart(format, 0, 1)
        let align = str2nr(strpart(format, 0)) - len(a:num)
    endif

    "如果有前缀零 填充字符为零字符 否则为空格
    if zero == '0'
        let ch = '0'
    else
        let ch = ' '
    endif

    "循环填充字符
    let r = ''
    for i in range(1, align)
        let r = r.ch
    endfor

    "如果有负号则左对齐 但只要有前缀零全为右对齐
    if sym == '-' && zero != '0'
        let r = a:num.r
    else
        let r = r.a:num
    endif

    let r = strpart(a:string, 0, s).r.strpart(a:string, e + 1)

    return r
endfunction


function! KyoNBSeq(...) range
"{
    let opt = KyoNBArgs(a:000)
    let indent_num = 80

    for lineno in range(a:firstline, a:lastline)
        let id = indent(lineno)
        if indent_num > id
            let indent_num = id
        endif
    endfor

    for lineno in range(a:firstline, a:lastline)
        let line = getline(lineno)
        let newline = strpart(line, 0, indent_num)
        let newline = newline.KyoNBFormat(opt[2], opt[0])
        let newline = newline.strpart(line, indent_num)
        call setline(lineno, newline)
        let opt[0] = opt[0] + opt[1]
    endfor

    return 0
"}
endfunction

command! -range=% -nargs=* Seq <line1>,<line2>call KyoNBSeq(<f-args>)

require("famiclone")

vim.cmd([[
autocmd BufEnter term://* startinsert
autocmd BufWinLeave term://* call CloseTerminalOnExit()
function! CloseTerminalOnExit()
    if &buftype ==# 'terminal' && v:term_job_id !=# -1
        let job_id = v:term_job_id
        call timer_start(100, {-> Check_job_status(job_id)})
    endif
endfunction
function! Check_job_status(job_id)
    let job_status = job_info(a:job_id)['status']
    if job_status !=# 'run'
        call timer_stopall()
        q
    endif
endfunction
]])

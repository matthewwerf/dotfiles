" call neomake#configure#automake("w")

let g:neomake_open_list = 0
let g:neomake_list_height = 5

" Change error/warning sign to something that works on both linux and OS X well.
let g:neomake_warning_sign = {'text': 'W>', 'texthl': 'airline_z'}
let g:neomake_error_sign = {'text': 'E>', 'texthl': 'airline_a'}
" Run :so $VIMRUNTIME/syntax/hitest.vim to show all highlight groups.

" let g:neomake_javascript_enabled_makers = ["eslint"]

" C++ settings
" ========================================================================= {{{
let args = ['-Wall', '-pedantic', '-Wno-sign-conversion', '-Wno-c++11-extensions', '-std=c++11']

" If in a Git repository, add the root of the Git repo
if exists("g:repo")
    call add(args, '-I' . g:repo . '/include')
endif

" Include Eigen and Boost.
call add(args, '-I' . '/usr/local/Cellar/eigen/3.3.4/include/eigen3')
call add(args, '-I' . '/usr/local/Cellar/boost/1.66.0/include')

let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_maker = {
   \ 'exe': '/usr/local/opt/llvm/bin/clang++',
   \ 'args': args,
   \ }
" ========================================================================= }}}

" Python settings
" ========================================================================= {{{
let g:neomake_python_enabled_makers = ["mypy", "flake8"]
let g:neomake_python_mypy_makers = {
            \ 'args': [
            \ '--ignore-missing-imports',
            \ ],
            \ }

" If in a repository, check for a .flake8 file in the root.
if exists("g:repo") && filereadable(g:repo . '/.flake8')
    let flake8conf = g:repo . '/.flake8'
    let g:neomake_python_flake8_maker = {
                \ 'args': [
                \ '--config', flake8conf,
                \ ],
                \ }
endif

" If in a repository, check for a .pylintrc file in the root.
if exists("g:repo") && filereadable(g:repo . '/.pylintrc')
    let pylintrc = g:repo . '/.pylintrc'
    call add(g:neomake_python_enabled_makers, 'pylint')
    let g:neomake_python_pylint_maker = {
                \ 'args': [
                \ '--rcfile', pylintrc,
                \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
                \ ],
                \ }
endif

" If in repo, check for .pydocstyle config, otherwise ignore.
if exists("g:repo") && filereadable(g:repo . '/.pydocstyle')
    let pydocstyle = g:repo . '/.pydocstyle'
    let g:neomake_python_pydocstyle_maker = {
                \ 'args': [
                \ '--config', pydocstyle,
                \ ],
                \ 'errorformat': '%W%f:%l %.%#:,%+C %m',
                \ }
    call add(g:neomake_python_enabled_makers, 'pydocstyle')
endif
" ========================================================================= }}}

" Shell/Bash settings
" ========================================================================= {{{
let g:neomake_sh_enabled_makers = ["shellcheck"]
let g:neomake_sh_shellcheck_maker = {
            \ 'args': ['-fgcc', '-x'],
            \ 'errorformat':
                \ '%f:%l:%c: %trror: %m,' .
                \ '%f:%l:%c: %tarning: %m,' .
                \ '%f:%l:%c: %tote: %m'
            \}
" ========================================================================= }}}

" Rust settings
" ========================================================================= {{{
let g:neomake_rust_enabled_makers = ["cargo"]
let g:neomake_rust_cargo_command = ["check", "--all-targets"]
" ========================================================================= }}}

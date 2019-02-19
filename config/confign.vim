"
" ---------------------
"
" NeoVim configuration
"
" @author = 'himkt'
"
" ---------------------
"

"" load basic vim configuration
source $HOME/.dotfiles/config/config.vim

"" If you have an error, `cd $HOME/.dotfiles && make requirements` may solve it.
let g:python3_host_prog = $PYENV_ROOT . '/versions/3.6.3/bin/python'

" load packages
source $HOME/.dotfiles/config/confign.tiny.vim

" use custom colorscheme
colorscheme iceberg

" Plug 'Shougo/denite.nvim'
call denite#custom#source('file_rec', 'sorters', ['sorter/word', 'sorter/reverse'])
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
nnoremap <silent> fu :<C-U>Denite file_rec -highlight-mode-insert=Search<CR>
nnoremap <silent> fg :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> ff :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>

" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary = $HOME . '/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME . '/work'
call deoplete#custom#source('_',  'max_menu_width', 0)

" Plug 'autozimu/LanguageClient-neovim'
set hidden
set completefunc=LanguageClient#complete
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'python': ['pyls']}
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" Plug 'Shougo/neosnippet'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory='~/.dotfiles/snippet'

" Plug 'scrooloose/nerdtree'
nnoremap <silent><C-e> : NERDTreeToggle<CR>

" Plug 'godlygeek/tabular'
vnoremap tr : <C-u>Tabularize<Space>/

" Plug 'majutsushi/tagbar'
nnoremap <silent><C-t> : TagbarToggle<CR>

" Plug 'osyo-manga/vim-anzu'
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
set statusline=%anzu#search_status()

" Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234

" Plug 'scrooloose/syntastic'
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -I' . $BREW_HOME . '/include'
let g:syntastic_cpp_check_header = 1
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_rust_checkers = ['rustc', 'cargo']

" Plug 'haya14busa/incsearch.vim'
map / <Plug>(incsearch-forward)

" Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['latex']

" Plug 'lervag/vimtex'
autocmd FileType tex setlocal omnifunc=vimtex#complete#omnifunc
let g:tex_flavor = "latex"
let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_open_on_warning = 0
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Plug 'tell-k/vim-autopep8'
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
  call Preserve(':silent %!autopep8 -')
endfunction

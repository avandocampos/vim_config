" Inicia o gerenciador de plugins
execute pathogen#infect()

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='apprentice'

" Floaterm plugin keymaps
let g:floaterm_keymap_new='<Leader>nt'  
let g:floaterm_keymap_kill='<Leader>kt'
"let g:floaterm_keymap_prev
"let g:floaterm_keymap_next
"let g:floaterm_keymap_first
"let g:floaterm_keymap_last
let g:floaterm_keymap_hide='<Leader>ht'
let g:floaterm_keymap_show='<Leader>st'
"let g:floaterm_keymap_toggle

" Organiza a tabulação e a numeração das linas
set number
set relativenumber
set tabstop=4 shiftwidth=4 expandtab
set softtabstop=4

" Reorganiza a tabulação de arquivos anteriormente tabulados
retab

filetype plugin indent on

syntax on

" Habilita a busca incremental e o destaque
set incsearch
set hlsearch 


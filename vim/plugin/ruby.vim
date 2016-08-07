augroup rubyfiles
  autocmd!
  autocmd BufRead,BufNewFile {Vagrantfile,Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.god} set ft=ruby
augroup END

" Run the current rspec file
nmap <leader>rs :Dispatch bundle exec rspec %<cr>

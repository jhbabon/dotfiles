

  
  if &background == 'dark'
    
  let s:shade0 = "#282629"
  let s:shade1 = "#474247"
  let s:shade2 = "#656066"
  let s:shade3 = "#847e85"
  let s:shade4 = "#a29da3"
  let s:shade5 = "#c1bcc2"
  let s:shade6 = "#e0dce0"
  let s:shade7 = "#fffcff"
  let s:accent0 = "#ff4050"
  let s:accent1 = "#f28144"
  let s:accent2 = "#ffd24a"
  let s:accent3 = "#a4cc35"
  let s:accent4 = "#26c99e"
  let s:accent5 = "#66bfff"
  let s:accent6 = "#cc78fa"
  let s:accent7 = "#f553bf"
  
  endif
  

  
  if &background == 'light'
    
  let s:shade0 = "#fffcff"
  let s:shade1 = "#e0dce0"
  let s:shade2 = "#c1bcc2"
  let s:shade3 = "#a29da3"
  let s:shade4 = "#847e85"
  let s:shade5 = "#656066"
  let s:shade6 = "#474247"
  let s:shade7 = "#282629"
  let s:accent0 = "#f03e4d"
  let s:accent1 = "#f37735"
  let s:accent2 = "#eeba21"
  let s:accent3 = "#97bd2d"
  let s:accent4 = "#1fc598"
  let s:accent5 = "#53a6e1"
  let s:accent6 = "#bf65f0"
  let s:accent7 = "#ee4eb8"
  
  endif
  

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
  let s:p.normal.left = [ [ s:shade1, s:accent5 ], [ s:shade7, s:shade2 ] ]
  let s:p.normal.right = [ [ s:shade1, s:shade4 ], [ s:shade5, s:shade2 ] ]
  let s:p.inactive.right = [ [ s:shade1, s:shade3 ], [ s:shade3, s:shade1 ] ]
  let s:p.inactive.left =  [ [ s:shade4, s:shade1 ], [ s:shade3, s:shade0 ] ]
  let s:p.insert.left = [ [ s:shade1, s:accent3 ], [ s:shade7, s:shade2 ] ]
  let s:p.replace.left = [ [ s:shade1, s:accent1 ], [ s:shade7, s:shade2 ] ]
  let s:p.visual.left = [ [ s:shade1, s:accent6 ], [ s:shade7, s:shade2 ] ]
  let s:p.normal.middle = [ [ s:shade5, s:shade1 ] ]
  let s:p.inactive.middle = [ [ s:shade4, s:shade1 ] ]
  let s:p.tabline.left = [ [ s:shade6, s:shade2 ] ]
  let s:p.tabline.tabsel = [ [ s:shade6, s:shade0 ] ]
  let s:p.tabline.middle = [ [ s:shade2, s:shade4 ] ]
  let s:p.tabline.right = copy(s:p.normal.right)
  let s:p.normal.error = [ [ s:accent0, s:shade0 ] ]
  let s:p.normal.warning = [ [ s:accent2, s:shade1 ] ]

  let g:lightline#colorscheme#ThemerDefaultLightline#palette = lightline#colorscheme#fill(s:p)

  

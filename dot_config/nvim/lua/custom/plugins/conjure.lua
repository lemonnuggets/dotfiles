return {
  'Olical/conjure',
  ft = { 'clojure', 'fennel', 'python' }, -- etc
  config = function(_, _)
    require('conjure.main').main()
    require('conjure.mapping')['on-filetype']()
  end,
  init = function()
    -- vim.g["conjure#debug"] = true
    vim.g['conjure_log_direction'] = 'vertical'
    vim.g['conjure#mapping#doc_word'] = false
    vim.g['conjure#mapping#def_word'] = false
    vim.g['conjure#highlight#enabled'] = false
    vim.g['conjure#log#hud#width'] = 0.6
    vim.g['conjure#log#hud#height'] = 0.4
    vim.g['conjure#log#hud#zindex'] = 1
    vim.g['conjure#log#wrap'] = true
    vim.g['conjure#log#fold#enabled'] = true
    vim.g['conjure#log#fold#lines'] = 10

    vim.g['floaterm_autoclose'] = 1
    vim.g['clojure_align_subforms'] = 1
  end,
}

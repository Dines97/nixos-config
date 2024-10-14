cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
    else
      fallback()
    end
  end,
  ['<Tab>'] = function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end,
  ['<S-Tab>'] = function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    elseif luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end
})


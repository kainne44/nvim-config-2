return {
  {
    'frabjous/knap',
    ft = { 'tex', 'plaintex' }, -- load only for TeX buffers
    init = function()
      -- KNAP settings (set globals before plugin loads)
      vim.g.knap_settings = {
        texoutputext = 'pdf',
        textopdf = 'latexmk -cd -dependents- -xelatex -interaction=nonstopmode -synctex=1 %docroot%',
        textopdfwatch = 'latexmk -cd -dependents- -xelatex -pvc -interaction=nonstopmode -synctex=1 %docroot%',
        textopdfviewerlaunch = 'open -a Skim %outputfile%',
        textopdfviewerrefresh = [[osascript -e 'tell app "Skim" to revert front document']],
        textopdfforwardjump = '/Applications/Skim.app/Contents/SharedSupport/displayline -g %line% %outputfile% %srcfile%',
        delay = 300,
      }
    end,
    config = function()
      -- Protect against load errors so Lazy doesn’t die
      local ok, knap = pcall(require, 'knap')
      if not ok then
        vim.notify('knap failed to load: ' .. tostring(knap), vim.log.levels.WARN)
        return
      end

      -- Keymaps (defined after plugin is available)
      local k, o = vim.keymap.set, { silent = true, noremap = true }
      k({ 'n', 'v', 'i' }, '<F5>', function()
        knap.process_once()
      end, o) -- build once
      k({ 'n', 'v', 'i' }, '<F6>', function()
        knap.close_viewer()
      end, o) -- close viewer
      k({ 'n', 'v', 'i' }, '<F7>', function()
        knap.toggle_autopreviewing()
      end, o) -- watch on/off
      k({ 'n', 'v', 'i' }, '<F8>', function()
        knap.forward_jump()
      end, o) -- forward jump

      -- Optional leader maps if your terminal eats F-keys:
      k('n', '<leader>kp', function()
        knap.process_once()
      end, { desc = 'KNAP build once' })
      k('n', '<leader>kw', function()
        knap.toggle_autopreviewing()
      end, { desc = 'KNAP watch' })
      k('n', '<leader>kv', function()
        knap.forward_jump()
      end, { desc = 'KNAP forward jump' })
      k('n', '<leader>kx', function()
        knap.close_viewer()
      end, { desc = 'KNAP close viewer' })
    end,
  },
}

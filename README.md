# Overview

I have forked the kickstart.nvim repo into a different repo as a baseline,
raw configuration of neovim. This is the first baseline of the additional
plugins I have added to that fork, as well as some of the color configs and
keybindings present from the previous neovim config I was using.

## Rationale

My previous config lacked some of the polish that I really wanted to have. Many
of the constituent files are unweildy and there was a lot of cleaning up that
needed to be done. Instead of doing that (lol) I decided to just start fresh
with a kickstart profile and snacks.nvim. From there, I added in more quality of
life elements, and have a config that I am pleased with.

I tried to slim down on much of the bloat from the previous config, but there is
still a lot of things present in this new one.

## Future Additions

I am interested in building out a note taking capability in neovim. I like
obsidian and its links, but I don't want to use their software. I like neorg but
I would prefer to use markdown. I like render-markdown.nvim, but it doesn't have
the linking I need. I like telekasten.nvim but it doesn't allow render-markdown
to work (I need to verify this, could just be a load order issue).

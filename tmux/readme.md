# Here's some problem I meet and solved

you can search the code in the `.tmux.conf` file.

## Correctly render the color of nvim on mac

I found that my diff color is not render correctly when I open vim inside tmux

Finally it works fine with the following config

```
set-option -sa terminal-overrides ',screen-256color:RGB'
set-option -sa terminal-overrides ',XXX:RGB'
```


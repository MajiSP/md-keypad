# md-keypad

A keypad script for FiveM.

### Installation

1. Place the `md-keypad` folder in your server's resources directory.
2. Add `ensure md-keypad` to your server.cfg file.

### Export

The export must be placed server-side. Use the following format to access the keypad functionality:

```lua
exports['md-keypad']:Open(player, password, callback)
exports['md-keypad']:Close(player)
```

### example usage

```lua
exports['md-keypad']:Open(source, 'password', function()
  print('Success!')
end)
```

The function will only call if the user enters the correct password.
Maximum of 4 characters for a password. 


### Made using [lj-boilerplate](https://github.com/loljoshie/lj-boilerplate)
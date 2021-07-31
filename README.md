# Rayex

> Warning: \
> WIP, many of the functions on raylib are yet not implemented, check the [contributing section](#contributing) to help

Rayex is an (almost) 1 to 1 binding with [raylib](https://www.raylib.com/)

## How to run

You need the following deps installed on your system:
* elixir
* raylib
* make

Now you can run:
```bash
mix deps.get
iex -S mix
```

To test if you can open a new window with raylib run (on iex)`
```bash
Rayex.Core.init_window 200, 200, 'window name'
```

## Contributing

There are a few things that you need to know about the code:
* This project aims to run each one of [those functions](https://www.raylib.com/cheatsheet/cheatsheet.html) with elixir
* To do so, we are building a generator that can be found at `lib/utils/generator/*`
* This generator will help with the writing of the `lib/rayex/*` and `src/raylib_*` (the elixir and C nif files)
* You can help building the generator or expanding these files, any will help a lot, because they are almost 1 to 1 so its easy to re-use the code, feel free to choose what fits you best
* The C source is automatically compiled using a mix task on `mix/task/compile_raylib.ex` that uses the `Makefile` under the hood
* If you want to help with the generator, please keep the tests updated and test the code! Also, if you want to help with the source files, please test the code too!

The `erl_nif.h` docs can be found [HERE](https://erlang.org/doc/man/erl_nif.html)

> Sidenote: \
> If you wanna help writing the C nifs, add the following export before opening your editor: \
> `export C_INCLUDE_PATH=$(erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)`

## License

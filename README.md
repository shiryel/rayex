# Rayex

> Warning: \
> WIP, many of the functions on raylib are yet not implemented, check the [contributing section](#contributing) to help

Rayex is an (almost) 1 to 1 binding with [raylib](https://www.raylib.com/)

## How to run

You need the following deps installed on your system:
* elixir
* raylib
* pkg-config

Now you can run:
```bash
mix deps.get
iex -S mix
```

Testing Rayex
```elixir
# open new window
Rayex.init_window 200, 200, 'window name'

# draw a line
Rayex.begin_drawing
Rayex.draw_line 10, 10, 50, 51, %{r: 255, g: 161, b: 0, a: 255}
Rayex.end_drawing
```

## Contributing

There are a few things that you need to know about the code:
* This project aims to run each one of [those functions](https://www.raylib.com/cheatsheet/cheatsheet.html) with elixir
* To do so, we are using [Unifex](https://hexdocs.pm/unifex/readme.html) to create NIFs

Any contributions are appreciated

## License

   Copyright 2021 Shiryel

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

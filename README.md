# [TDT4501 - Computer Science, Specialization Project](report/main.pdf)

## How to run the code

### Julia REPL

#### Activate the environment:
```sh
julia> ]
(@v1.8) pkg> activate code
```
To return to `julia>` mode, press `backspace` or `ctrl+c`.

#### To run files:
```sh
julia> include("code/<filename>.jl")
```

### VSCode

1. Make sure the [Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) is activated/installed.
2. Start the Julia REPL by using the command: `Julia: Start REPL` in the command palette.
3. Activating the environment in REPL as shown above
4. Run the desired (opened) file by hitting the *run* button.


### shell

```sh
<path/to/julia> --project=code code/<filename>.jl
```
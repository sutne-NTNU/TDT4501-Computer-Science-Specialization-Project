# [TDT4501 - Computer Science, Specialization Project](report/main.pdf)

## How to run the code

### Julia REPL

#### Activate the environment:
```sh
julia> ]
(@v1.8) pkg> activate code
```

#### To run files:
```sh
julia> include("code/src/<filename>.jl")
```

### VSCode

1. Make sure the [Julia extension](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia) is activated/installed.
2. Activating the environment in REPL as shown above
3. Run the desired (opened) file by hitting the *run* button.


### shell

```sh
<path/to/julia> --project=code code/main.jl
```
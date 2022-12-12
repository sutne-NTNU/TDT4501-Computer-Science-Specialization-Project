using code

include("util.jl")


function plot_mms_scatter_comparison(x, xlabel::String, y, ylabel::String)
    scatter_plot = scatter(x, y,
        xlabel=xlabel,
        ylabel=ylabel,
        markersize=1.5,
        markerstrokewidth=0.1,
        alpha=1.0,
        label="MMS",
        legend=:topleft,
        aspect_ratio=:equal,
        xlims=(0, 2),
        ylims=(0, 2),
    )
    # Add diagonal line for where x=y
    Plots.abline!(scatter_plot, 1, 0, line=:dash, label="", color=:red)
    return scatter_plot
end



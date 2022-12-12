include("util.jl")


function plot_mms_scatter_comparison(x, xlabel::String, y, ylabel::String)
    scatter_plot = scatter(x, y,
        xlabel=xlabel,
        ylabel=ylabel,
        markersize=3,
        alpha=1.0,
        label="MMS",
        legend=:topleft,
        aspect_ratio=:equal,
        xlims=(0, max(1.25, x...) + 0.25),
        ylims=(0, max(1.25, y...) + 0.25),
    )
    # Add diagonal line for where x=y
    Plots.abline!(scatter_plot, 1, 0, line=:dash, label="", color=:red)
    return scatter_plot
end



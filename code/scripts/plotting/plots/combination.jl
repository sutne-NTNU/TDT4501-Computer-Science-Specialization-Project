using code
using Plots

include("util.jl")
include("scatter.jl")
include("histogram.jl")
include("pie.jl")

function compare_mms_diagram(title::String, x, xlabel::String, y, ylabel::String)

    scatter_plot = plot_mms_scatter_comparison(x, xlabel, y, ylabel)
    pie_percetnages = plot_mms_pie_percentages(x, xlabel, y, ylabel)
    histogram = plot_mms_histogram_comparison(x, xlabel, y, ylabel)

    return plot(
        scatter_plot, pie_percetnages, histogram,
        layout=(@layout [a{0.7w} b{0.3w}; c{0.275h}]),
        size=(config.width, config.width),
        plot_title=title
    )
end
function plot_mms_scatter_comparison(title::String, x, xlabel::String, y, ylabel::String)
    scatter_plot = scatter(x, y,
        label="MMS",
        xlabel=xlabel,
        ylabel=ylabel,
        markersize=2,
        aspect_ratio=:equal,
        xlims=(0, max(1.25, x...) + 0.25),
        ylims=(0, max(1.25, y...) + 0.25),
    )
    Plots.abline!(scatter_plot, 1, 0, line=:dash, label="", color=:red) # diagonal line

    x_wins = 0
    y_wins = 0
    equal = 0
    for (x_i, y_i) in zip(x, y)
        if x_i > y_i
            x_wins += 1
        elseif x_i < y_i
            y_wins += 1
        else
            equal += 1
        end
    end

    n = length(x)
    x_win_percentage = @sprintf("%.1f", 100 * x_wins / n)
    y_win_percentage = @sprintf("%.1f", 100 * y_wins / n)
    equal_percentage = @sprintf("%.1f", 100 * equal / n)

    pie_chart = pie(
        ["$xlabel: $x_win_percentage%"; "$ylabel $y_win_percentage%"; "Equal: $equal_percentage%"],
        [x_wins, y_wins, equal],
        legend=:bottomleft,
    )

    return plot(
        scatter_plot,
        pie_chart,
        layout=(@layout [a{0.65w} b{0.35w}]),
        plot_title=title
    )
end


function plot_mms_histogram_comparison(title::String, x, xlabel::String, y, ylabel::String)
    bins = range(0, 1.5, length=50)

    fig = plot(title=title, xlabel="MMS", ylabel="Count",)
    fig = histogram!(x, label=xlabel, bins=bins, alpha=0.5)
    fig = histogram!(y, label=ylabel, bins=bins, alpha=0.5)
    return fig
end
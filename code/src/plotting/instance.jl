function plot_instance(title::String, instance::Instance)
    fig = groupedbar(
        instance.valuations,
        title=title,
        bar_width=0.8,
        label="Label",
    )
    return fig
end

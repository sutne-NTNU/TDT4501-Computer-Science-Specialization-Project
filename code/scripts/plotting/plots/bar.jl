using code
using Plots
using Plots.PlotMeasures
using StatsPlots

include("util.jl")

function plot_instance(title::String, instance::Instance)
    return groupedbar(
        instance.valuations,
        title=title,
        bar_width=0.8,
        legend=:topleft,
        size=(config.width, 200),
        xticks=(Agents(instance), get_agent_labels(instance)),
        label=get_good_labels(instance),
    )
end


function plot_allocation_for_agents(title::String, allocation::MixedAllocation)
    l = (@layout [
        a{0.000001h}
        b c d
    ])
    plots = [plot(title=title, grid=false, xaxis=false, yaxis=false)]

    highest_bundle_value = 0
    for agent in Agents(allocation.instance)
        alphas = [
            if a == agent
                1.0
            else
                0.3
            end for a in 1:allocation.instance.num_agents
        ]
        valuation = allocation.instance.valuations[agent, :]
        bundles = valuation' .* allocation.assigned
        agent_plot = groupedbar(
            title="Agent $agent",
            bundles,
            yaxis=:none,
            bar_position=:stack,
            bar_width=0.8,
            alpha=alphas,
            legend=false,
            label=get_good_labels(allocation.instance),
            xticks=(Agents(allocation.instance), get_agent_labels(allocation.instance)),
        )
        mms = mms_mixed(allocation.instance, agent).maximin
        hline!([mms], color=:black, linestyle=:dash, label="MMS")
        hline!([0.5 * mms], color=:red, linestyle=:dash, label="1/2 MMS")
        push!(plots, agent_plot)
        highest_bundle_value = max(highest_bundle_value, maximum(sum(bundles, dims=2)))
    end
    return plot(plots..., layout=l, size=(config.width, 250), ylims=(0, highest_bundle_value))
end




function plot_mms_allocation_for_agents(title::String, instance::Instance)
    # create plot layout with empty space on top for the header (prevent overlap)
    l = (@layout [
        a{0.000001h}
        b c d
    ])
    plots = [plot(title=title, grid=false, xaxis=false, yaxis=false)]

    highest_bundle_value = 0
    for agent in Agents(instance)
        # get the MMS allocation for this agent
        allocation = mms_mixed(instance, agent).allocation

        bundles = allocation.instance.valuations .* allocation.assigned
        bundle_chart = groupedbar(
            bundles,
            title="Agent $agent",
            bar_position=:stack,
            bar_width=0.8,
            legend=false,
            label=get_good_labels(allocation.instance),
            xticks=(Agents(allocation.instance), get_bundle_labels(allocation.instance)),
        )
        highest_bundle_value = max(highest_bundle_value, maximum(sum(bundles, dims=2)))
        push!(plots, bundle_chart)
    end

    return plot(plots..., size=(config.width, 200), layout=l, ylims=(0, highest_bundle_value))
end
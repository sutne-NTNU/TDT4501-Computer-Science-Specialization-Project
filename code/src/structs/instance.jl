"""
An instance defines all items and agents valuations of these items
"""
mutable struct Instance
    valuations::Matrix{Float64} # valuations[a, g] is the value agent 'a' assigns to good 'g'
    num_agents::Int # number of agents in the instance
    num_items::Int # number of items in the instance, corresponds to first `num_items` in valuations
    num_cakes::Int # number of cakes in the instance, corresponds to last `num_cakes` in valuations
    num_goods::Int # Total number of items and cakes in the instance

    function Instance(valuations::Matrix{Float64}, num_agents::Int, num_items::Int, num_cakes::Int, num_goods::Int)
        new(valuations, num_agents, num_items, num_cakes, num_goods)
    end
end


""" Initialize a new instance with random valuations from 0 to 1 for all goods """
function Instance(; num_agents::Int, num_goods::Int, cake_size::Int)
    # original plan was for the algorithms to be able to handle any number of cakes, 
    # unfortunately there wasnt time to allow the mixed algorithm to fully support this 
    # so all instances has exactly 1 cake for now.
    num_cakes = 1
    cake_index = num_goods
    num_items = num_goods - num_cakes

    valuations = rand(num_agents, num_goods)
    # Adjust valuation of cake depending on its size
    for agent in 1:num_agents
        # Value of cake for each agent is equal to or lower than the lowest valued good of the agent
        small = minimum(valuations[agent, :])
        # Value of cake for each agent is equal the highest valued item of the agent
        medium = maximum(valuations[agent, 1:num_items]) # only look at the items to prevent overlap of medium and large cakes
        # Value of cake is the sum of all other items value
        large = sum(valuations[agent, :])

        if cake_size == 1
            valuations[agent, cake_index] = small
        elseif cake_size == 2
            valuations[agent, cake_index] = medium
        elseif cake_size == 3
            valuations[agent, cake_index] = large
        elseif cake_size == 4
            # Each agents can have different size of their cake
            valuations[agent, cake_index] = rand([small, medium, large])
        else
            error("Invalid cake size: $cake_size")
        end
    end
    return Instance(valuations, num_agents, num_items, num_cakes, num_goods)
end

""" Initialize an Instance with valuation profile `valuations`, the final column of `valuations` is valuations for the cake """
function Instance(valuations::Matrix{Float64})
    num_goods = size(valuations, 2)
    num_cakes = 1
    num_items = num_goods - 1
    num_agents = size(valuations, 1)
    return Instance(valuations, num_agents, num_items, num_cakes, num_goods)
end

""" Create a clone of the given `clone_instance`, optionally assign `agent`'s valuations to all agents (for MMS calculation) """
function CloneInstance(clone_instance::Instance, ; agent::Int=0)
    valuations = clone_instance.valuations[:, :]
    if agent != 0
        for clone_agent in Agents(clone_instance)
            valuations[clone_agent, :] = clone_instance.valuations[agent, :]
        end
    end
    return Instance(valuations, clone_instance.num_agents, clone_instance.num_items, clone_instance.num_cakes, clone_instance.num_goods)
end

Agents(instance::Instance) = 1:instance.num_agents
Goods(instance::Instance) = 1:instance.num_goods
Cakes(instance::Instance) = (instance.num_items+1):instance.num_goods
Items(instance::Instance) = 1:instance.num_items

""" (size, name) iterator for all cake variations """
CakeSizes() = enumerate(["Small", "Medium", "Large", "Individual"])
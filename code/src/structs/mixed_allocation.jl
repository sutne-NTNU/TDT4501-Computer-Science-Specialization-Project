"""
An Allocation is a collection of all goods in an instance into bundles for all the agents.
"""
mutable struct MixedAllocation
    instance::Instance
    assigned::Matrix{Float64} # alloc[a, g] is in the range [0, 1] and is the fraction of good 'g' that agent 'a' gets

    function MixedAllocation(instance::Instance)
        assigned = zeros(instance.num_agents, instance.num_goods)
        new(instance, assigned)
    end
end




"""
    calc_mms_values(allocation::MixedAllocation) -> []

Calculate the MMS value for each agent in the allocation.
"""
function calc_mms_values(allocation::MixedAllocation)
    if (!is_valid(allocation))
        visualize(allocation.instance)
        visualize(allocation.assigned)
        throw(ArgumentError("Allocation is not valid"))
    end
    mms_values = zeros(allocation.instance.num_agents)
    for (agent, assigned) in enumerate(eachrow(allocation.assigned))
        sum = 0
        for (good, valuation) in enumerate(allocation.instance.valuations[agent, :])
            sum += assigned[good] * valuation
        end
        mms_values[agent] = sum / mms_mixed(allocation.instance, agent).maximin
    end
    return mms_values
end


"""
Make sure each good is fully allocated/assigned to the agents
"""
function is_valid(allocation::MixedAllocation)
    for good in eachcol(allocation.assigned)
        if abs(sum(good) - 1) >= 0.0001
            return false
        end
    end
    return true
end


""" Convert result from `Allocations` alloc to MixedAllocation """
function from_Allocations(alloc, instance::Instance, num_pieces::Int)
    # Convert into MixedAllocation and return
    allocation = MixedAllocation(instance)
    for agent in Agents(instance)
        bundle = alloc.alloc.bundle[agent]
        # copy ownership of indivisible items
        for item in Items(instance)
            if item in bundle
                allocation.assigned[agent, item] = 1
            end
        end
        # accumulate ownership of cake pieces
        for cake in Cakes(instance)
            for piece in [(cake + cut) for cut in 0:num_pieces-1]
                if piece in bundle
                    allocation.assigned[agent, cake] += 1 / num_pieces
                end
            end
        end
    end
    return allocation
end
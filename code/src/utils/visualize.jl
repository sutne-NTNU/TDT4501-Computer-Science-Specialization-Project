""" Print all instance information in easy to read format """
function visualize(instance::Instance)
    println("\nInstance:")
    goods = [
        if g in Cakes(instance)
            "🎂"
        else
            "💍"
        end for g in 1:instance.num_goods
    ]
    println("\tGoods:   $(goods)")
    for (agent, valuations) in enumerate(eachrow(instance.valuations))
        mms = mms_mixed(instance, agent).maximin
        print("\tAgent $agent: $(to_string(valuations))")
        print(" - MMS: $(to_string(mms))\n")
    end
end



""" Print the allocation in a easy-to-read way with its lowest MMS value """
function visualize(allocation::MixedAllocation)
    mms = calc_mms_values(allocation)
    println("Allocation $(if is_valid(allocation) "✅" else "❌" end):  MMS=$(to_string(min(mms...)))")
    for (agent, assigned) in enumerate(eachrow(allocation.assigned))
        sum = 0
        for (good, valuation) in enumerate(allocation.instance.valuations[agent, :])
            sum += assigned[good] * valuation
        end
        print("\tAgent $agent: $(to_string(assigned))")
        print(" - Bundle Sum: $(to_string(sum)) \tMMS: $(to_string(mms[agent]))\n")
    end
end


function visualize(mat::Matrix{Float64})
    for row in eachrow(mat)
        println(to_string(row))
    end
end

""" Print the allocation in a easy-to-read way with its lowest MMS value """
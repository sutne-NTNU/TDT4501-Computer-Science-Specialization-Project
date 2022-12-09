using code
using Revise


function visualize_mms(instance::Instance)
    visualize(instance)
    # Print each agents MMS allocation
    for agent in Agents(instance)
        println("Agent $agent's MMS Allocation:")
        allocation = mms_mixed(instance, agent).allocation
        for (a, assigned) in enumerate(eachrow(allocation.assigned))
            sum = 0
            for (good, valuation) in enumerate(allocation.instance.valuations[a, :])
                sum += assigned[good] * valuation
            end
            print("\tAgent $a: $(code.to_string(assigned))")
            print(" - Sum: $(code.to_string(sum))\n")
        end
    end
end


function test_mms()
    instance = Instance(num_agents=3, num_goods=4, cake_size=1)
    visualize_mms(instance)
    instance = Instance(num_agents=3, num_goods=4, cake_size=2)
    visualize_mms(instance)
    instance = Instance(num_agents=3, num_goods=4, cake_size=3)
    visualize_mms(instance)
end

test_mms()

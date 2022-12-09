"""
Use the `alloc_half_mms` from the `Allocations` package to allocate all gods and cake as if they were indivisible.
`num_pieces` is how many cuts to make in each cake.
"""
function alloc_half_mms(instance::Instance, num_pieces::Int=1)
    # Convert to use Allocation Package
    if num_pieces == 1 || instance.num_cakes == 0
        # no cakes or no cuts, all items are indivisible
        additive = Additive(instance.valuations)
        counts = Counts([n => instance.num_goods for n in 1:instance.num_goods]...)
    else
        # cut each cake into `num_pieces` pieces
        total_goods = instance.num_items + (instance.num_cakes * num_pieces)
        additive = Additive(instance.num_agents, total_goods)
        counts = Counts([n => total_goods for n in 1:total_goods]...)
        for agent in Agents(instance)
            # start by copying over valuation for indivisible items directly
            for item in Items(instance)
                additive.values[agent, item] = instance.valuations[agent, item]
            end
            # adjust and add valuations to cake pieces
            for cake in Cakes(instance)
                piece_value = instance.valuations[agent, cake] / num_pieces
                for piece in [cake + cut for cut in 0:num_pieces-1]
                    additive.values[agent, piece] = piece_value
                end
            end
        end
    end

    # Allocate using the Allocation Package
    alloc = Allocations.alloc_half_mms(additive, counts)

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
            # cake is good 1, cut in 3 pieces means pieces have id 1, 2, 3 in bundle
            for piece in [(cake + cut) for cut in 0:num_pieces-1]
                if piece in bundle
                    allocation.assigned[agent, cake] += 1 / num_pieces
                end
            end
        end
    end
    return allocation
end
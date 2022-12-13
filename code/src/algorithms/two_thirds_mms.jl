"""
Use a 2/3 MMS algorithm for indivisible goods from the `Allocations` package.
"""
function alloc_two_thirds_mms(instance::Instance, num_pieces::Int=1)
    converted = to_Allocations(instance, num_pieces)

    # Allocate using the Allocation Package
    alloc = Allocations.alloc_gmt18(converted.additive)

    allocation = from_Allocations(alloc, instance, num_pieces)

    return allocation
end
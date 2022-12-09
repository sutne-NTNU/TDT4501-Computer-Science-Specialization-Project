function mms(instance::Instance, agent::Int)
    additive = Additive(instance.valuations)
    res = Allocations.mms(additive, agent)
    return res.mms
end
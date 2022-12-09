""" 
    var = [1.234324, 2.345234, 3.456234]
    to_string(var) -> "[1.23, 2.35, 3.46]"

round numbers to 2 deciaml places, and then convert list of strings to a single string (for prettier printing) 
"""
function to_string(var)
    return @sprintf("[%s]", join([to_string(x) for x in var], ", "))
end


""" 
    flt = 1.234324
    to_string(var) -> "1.23"

round numbers to 2 deciaml places
"""
function to_string(flt::Float64)
    return @sprintf("%.2f", flt)
end
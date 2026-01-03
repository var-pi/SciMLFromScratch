entr(["src", "test"]) do
    try
        include("runtests.jl")
    catch err
        println(err)
    end
end

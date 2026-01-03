using SciMLFromScratch

function watch_tests()
    entr(["test"], [SciMLFromScratch]) do
        try
            include("test/runtests.jl")
        catch err
            println(err)
        end
    end
end


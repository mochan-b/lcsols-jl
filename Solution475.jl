using Test

function findHeater(house, heaters)
    left = 1
    right = size(heaters,1)

    while left <= right
        mid = left + (right - left) ÷ 2
        if heaters[mid] == house
            return mid
        elseif heaters[mid] < house 
            left = mid + 1
        else
            right = mid - 1
        end
    end
    return left
end

function findRadius(houses, heaters)
    sort!(houses)
    sort!(heaters)

    maximum(map(function (house)
        heaterIndex = findHeater(house, heaters)
        
        leftDistFn() = house - heaters[heaterIndex - 1]        
        rightDistFn() = heaters[heaterIndex] - house

        heaterIndex == 1 ? rightDistFn() : (heaterIndex == (size(heaters,1)+1) ? leftDistFn() : min(leftDistFn(), rightDistFn()))
    end, houses))
end

@testset "Problem 475" begin
    @testset "[1,2,3], 2 = 2" begin
        house = 2
        heaters = [1,2,3]
        @test findHeater(house, heaters) == 2
    end

    @testset "[1,2,3,6,8], 6 = 4" begin
        house = 6
        heaters = [1,2,3,6,8]
        @test findHeater(house, heaters) == 4
    end

    @testset "[1,2,3], [2] = 1" begin
        houses = [1, 2, 3]
        heaters = [2]
        @test findRadius(houses, heaters) == 1
    end

    @testset "[1,3,2], [2] = 1" begin
        houses = [1, 3, 2]
        heaters = [2]
        @test findRadius(houses, heaters) == 1
    end

    @testset "[1,2,3, 4], [1,4] = 1" begin
        houses = [1, 2, 3, 4]
        heaters = [1,4]
        @test findRadius(houses, heaters) == 1
    end

    @testset "[1, 5], [2] = 1" begin
        houses = [1, 5]
        heaters = [2]
        @test findRadius(houses, heaters) == 3
    end

    @testset "[1, 5], [10] = 1" begin
        houses = [1, 5]
        heaters = [10]
        @test findRadius(houses, heaters) == 9
    end

    @testset "unsorted heaters" begin
        houses = [282475249, 622650073, 984943658, 144108930, 470211272, 101027544, 457850878, 458777923]
        heaters = [823564440, 115438165, 784484492, 74243042, 114807987, 137522503, 441282327, 16531729, 823378840, 143542612]
        @test findRadius(houses, heaters) == 161834419
    end

    @testset "[474833169,264817709,998097157,817129560],[197493099,404280278,893351816,505795335]" begin
        houses = [474833169, 264817709, 998097157, 817129560]
        heaters = [197493099, 404280278, 893351816, 505795335]
        @test findRadius(houses, heaters) == 104745341
    end
end
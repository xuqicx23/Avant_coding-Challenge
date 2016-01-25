class Solution
    
	def factors(input_arr)

		myHash = Hash.new()
		# Here is the first difference, sort the input_arr in descending order.
		# The rest function stay the same
		@my_arr = input_arr.sort.reverse
		@my_arr.each_index { |i|
            if myHash.key?(@my_arr[i]) == false
                #if @my_arr[i] is not in the hash table, create a new map for it.
                myHash[@my_arr[i]] = []
            end
            j = 0; # @my_arr has been sorted, so we just need to iterate the left side of the array util current element to get all the factors
            until j == i
                cache(@my_arr[j], @my_arr[i], myHash) # Call cache function which would calculate, push factors into hash table
                j += 1
            end
        }
		print ( "Given array " )
        p (input_arr )
        print ( "The output is ")
        print ( "{ " )
		input_arr.each_index { |i| 
		print (input_arr[i].to_s + ": " + myHash[input_arr[i]].to_s + ", ")
		}
        print ( "}" )
        print ( "\n")
	end
	
    # Overall cache method is the same, only difference is checking for multiples instead of factors
	def cache(subfactor, index, myHash)
        # if subfacotr has included in the Hash table, skip the calculation
		if myHash[index].index(subfactor) != nil
		return
		end
		# In my implementation, I assume that factors are not negative numbers,
		# Therefore, I make second change to examine whether index is negative
        if index <= 0
            return
        end
        # Here is the third change, just change index % subfactor into subfactor % index.
		if subfactor != index && subfactor % index == 0
			myHash[index].push( subfactor )
			if myHash[subfactor].length != 0 # Corner Case! Subfactor itself has been calculated and has its own array of multiples
                #so no need to calculate. Just push the whole array into hash table
				myHash[index].push(myHash[subfactor]).flatten!.uniq! # pay attention we need to avoid duplicates.
			end
		end
	end
    
end
p ( "# Test1" )
obj = Solution.new
obj.factors( [10, 5, 2, 20] )

p ( "# Test2" )
obj = Solution.new
obj.factors( [1, 3, 5, 10, 2, 300, 2, 100, 125, 0] )

p ( "# Test3" )
obj = Solution.new
obj.factors( [] )

p ( "# Test4" )
obj = Solution.new
obj.factors( [-1, 2, -3, -9, 12, 26] )
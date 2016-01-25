class Solution
    
    # factors method displays my solution: I sort the input array in ascending order first
    # Then I only need to search the elements on the left of the current element to get all factors
    # I build a Hash table to store each element and its factors array.
	def factors(input_arr)
        #Because I will sort the input array, so I copy this array and sort this "copied" array, do not change the input
        #file. In fact, it is not necessary. I just consider I need to maintain the input file.
        len = input_arr.size
        @my_arr = Array.new(len) {|e|
            e = input_arr[e]
        }
        #creating a hash table,each element in input array is key,
        #use the array containing all the factors of that element as value
		myHash = Hash.new()
		@my_arr.sort!.each_index { |i|
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
        #myHash stores factors array for each given element
        #Below is just standard output to print the result onto the screen
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
	
    # cache function would calculate whether subfactor is factors of index element
    # If so, push the element into the Hash table
    # Skip calculation if subfactor itself has already been calculated
	def cache(subfactor, index, myHash)
        # if subfacotr has included in the Hash table, skip the calculation
		if myHash[index].index(subfactor) != nil
		return
		end
        # below is just a math problem: Assume factors here do not include non-positive numbers
        # If input non-positive elements, continue finding other positive factors. See Test 4
        if subfactor <= 0
            return
        end
        #if it needs calculation && it is the factor of index, push into hashtable
		if subfactor != index && index % subfactor == 0
			myHash[index].push( subfactor )
			if myHash[subfactor].length != 0 # Corner Case! Subfactor itself has been calculated and has its own array of factors
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
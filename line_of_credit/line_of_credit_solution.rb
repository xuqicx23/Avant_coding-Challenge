class Line_of_credit
    
	#For this credit card class, user can access creditlimits, APR
	#Read only for principle banlance, remain_credit, transactions
	attr_writer :credit_limit, :apr
	attr_reader :credit_limit, :apr, :principle_balance, :remain_credit, :transactions
	
	@@payment_cycle = 30 # Define a class variable for 30 days payment period
	
	#Initializer for initialize all the fields in this credit card
	def initialize credit_limit, apr
		@credit_limit = credit_limit
		@apr = apr
		@principle_balance = 0
		@remain_limit = credit_limit
		@transactions = []
	end
	
	#Card has to be able draw money, resulted in the increase of principle and decrease of remain_credit
	def draw amount, day
        # When draw amount exceeds the remain credit
		if amount > @remain_limit
			print ( " No Enough credit remaining for draw money!")
			return
		else
			@remain_limit -= amount
			@principle_balance += amount
			#after we draw money, we need to update the transactions array to keep track.
			if @transactions[day] != nil
				@transactions[day] += amount
			else
                #transactions at this day is empty, create for it
                @transactions[day] = amount
			end
		end
	end
	
	
	#Card has also to be able to pay back, resulted in the decrease of principle and increase of remain_credit
	def pay_back amount, day
        # when pay_back amount exceeds the principle_balance I need to pay, I print out this message
        # and principle would be negative, I use negative in calculation to shows that these amount
        # of money is left in your card.
        if amount > @principle_balance
            p ( "pay_back amount larger than principle_balance in the card" )
        end
        #decrease principle amount and increase remain credit limits
        @principle_balance -= amount
        @remain_limit += amount
        #After we pay back amount, update the transactions array for keeping track
        if @transactions[day] != nil
            @transactions[day] += -amount
        else
            # No transactions this day, create transactions for it
            @transactions[day] = -amount
        end
	end
	
	#In the end, we need to calculate the amount pay at the end of month
	def calculation
        #Initialize the interest to be 0
		interest = 0
        # we need to keep track the time of last transaction
		prev_payday = 0
        # we need to keep track of the principle amount after last transaction
		prev_principle = 0
        # we get transactions[i] as the current transaction
		curr_principle = 0
        
		#It is trick to ensure the last day transaction exists
		@transactions[@@payment_cycle] = transactions[@@payment_cycle] || 0
		@transactions.each_index { |i|
			transaction = @transactions[i]
			
			if transaction != nil
				curr_principle += transaction
				# Calculate the interest since last payment
				interest += prev_principle * apr / 365 * (i - prev_payday)
                # we have made a payment at i day, we need to decide where should we start next time
				prev_payday = i > 1 ? i : 0
				#make curr_principle become prev for the calculation next time
				prev_principle = curr_principle
			end
		}
        res = curr_principle + interest.round(2)
        if res < 0 # when user pay_back too much before the end of month, I can show him that money left in his card
            print( "Money left in your card " )
            print ( -res )
            puts ( "$" )
        else
		print ( res ) # return the total amount at the end of month
        puts ( "$" )
        end
	end
    
end

p ( "Scenario 1:" )
#create a line of credit with 1000, 35%
obj1 = Line_of_credit.new(1000, 0.35)
#draws 500$ on day one
obj1.draw(500, 1)
obj1.calculation

p ( "Scenario 2:" )
#create a line of credit with 1000, 35%
obj2 = Line_of_credit.new(1000, 0.35)
# draws 500$ on day one
obj2.draw(500, 1)
# pays back 200$ on day 15
obj2.pay_back(200, 15)
# draws another 100$ on day 25
obj2.draw(100, 25)
obj2.calculation

p ( "Scenario 3:" )
#create a line of credit with 0 credit, 35%
obj3 = Line_of_credit.new(0, 0.35)
#draws 100$ on day two
obj3.draw(100,2)
obj3.calculation

p ( "Scenario 4:" )
#create a line of credit with 1000, credit, 35%
obj4 = Line_of_credit.new(1000, 0.35)
#draws 200$ on 15 day
obj4.draw(200, 15)
#pay_back 1000$ on day 20
obj4.pay_back(1000, 20)
obj4.calculation
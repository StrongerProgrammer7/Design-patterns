#Task1---------------------------------------------
def primeDevider(num)
  for i in 2..Math.sqrt(num)
	if(num%i==0) then
	  return 0
	end
  end
return 1
end

def sumPrimeDivisor(num)
  sum = 0
  for i in 1..((num**0.5)+1)
	if (i*i==num and primeDevider(i)==1) then
	  sum+=i
	else
	  if (num % i == 0 and primeDevider(i)==1) then
	    sum+=i
	    temp=num/i
	    temp = temp.round
	    if (primeDevider(temp)==1) then
	    	sum+=temp
        end
	  end
	end
  end
return sum
end

#Task2---------------------------------------------
def countOddDigitsNumber(num,minSizeDigit=nil)
	count=0
	while(num!=0)
		temp=num%10
		if(temp>minSizeDigit) then
			count = count+1
		end
		num /=10
	end
return count
end

puts countOddDigitsNumber(1924924,3)
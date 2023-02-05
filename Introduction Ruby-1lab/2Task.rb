#Common method----------------------------
def isPrimeDevider(num)
  for i in 2..Math.sqrt(num)
	if(num%i==0) then
	  return 0
	end
  end
return 1
end

def setDivisorNumber(num)
	divisors = Array.new
	for i in 1..((num**0.5)+1)
		if(i*i==num) then
			divisors.push(i)
		else
			if(num%i==0) then
				divisors.push(i)
				temp=num/i
				temp=temp.round
				divisors.push(temp)
			end
		end
	end
	return divisors
end

def isOddDigit(digit)
	return digit%2==0 ? 0 : 1
end

def setDigitsNumber(num)
	setDigits = Array.new
	while(num!=0)
		setDigits.push(num%10)
		num /=10
	end
	return setDigits
end

def sumDigitsNumber(num)
	return setDigitsNumber(num).sum
end

#Task1---------------------------------------------
def sumPrimeDivisorNumber(num)
  return setDivisorNumber(num).sum { |div| if isPrimeDevider(div)==1 then div else 0 end }
  #return setDivisorNumber(num).each { |div| sum += if isPrimeDevider(div)==1 then div else 0 end }
end

#puts sumPrimeDivisorNumber(25)

#Task2---------------------------------------------
def countOddDigitsNumber(num,minSizeDigit=nil)
	return setDigitsNumber(num).count { |dig| isOddDigit(dig)==1 and dig>minSizeDigit }
end

#puts countOddDigitsNumber(1924924,3)

#Task3---------------------------------------------
def multDivNumberSumDigLessSumDigOriginalNum(num)
	sumDigOriginalNumber = sumDigitsNumber(num)
	mult = 1 
	setDivisorNumber(num).each { |div| if sumDigitsNumber(div) < sumDigOriginalNumber then mult*=div end}
	return mult
end

puts multDivNumberSumDigLessSumDigOriginalNum(36)
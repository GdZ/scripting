
-- return the element before the last

lastButOne xs = if null (tail (tail xs))
		then head xs
		else lastButOne (tail xs)

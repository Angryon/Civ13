/*
 * Holds procs to help with list operations
 * Contains groups:
 *			Misc
 *			Sorting
 */

/*
 * Misc
 */

// "locate() in list" tends not to work, so here's a version that works for both objects and lists - Kachnov
// interesting to note, istype() works even when the first argument isn't an object. We use this to bypass some type checking, making these fairly-common procs faster

/proc/locate_type(var/L, var/type)
	if (isatom(L))
		var/atom/A = L
		L = A.contents
	for (var/D in L)
		if (istype(D, type))
			return D
	return FALSE

/proc/locate_dense_type(var/L, var/type)
	if (isatom(L))
		var/atom/A = L
		L = A.contents
	for (var/A in L)
		if (istype(A, type) && A:density)
			return A
	return FALSE

/proc/locate_opaque_type(var/L, var/type)
	if (isatom(L))
		var/atom/A = L
		L = A.contents
	for (var/A in L)
		if (istype(A, type) && A:opacity)
			return A
	return FALSE

/proc/locate_bullet_blocking_structure(var/list/L)
	if (isatom(L))
		var/atom/A = L
		L = A.contents
	for (var/obj/structure/structure in L)
		if (structure.throwpass || !structure.density)
			continue
		return TRUE
	return FALSE

/proc/copylist(var/list/L)
	if (!L || !islist(L))
		return list()
	return L.Copy()

//Returns a list in plain english as a string
/proc/english_list(var/list/input, nothing_text = "nothing", and_text = " and ", comma_text = ", ", final_comma_text = "" )
	var/total = input.len
	if (!total)
		return "[nothing_text]"
	else if (total == TRUE)
		return "[input[1]]"
	else if (total == 2)
		return "[input[1]][and_text][input[2]]"
	else
		var/output = ""
		var/index = TRUE
		while (index < total)
			if (index == total - 1)
				comma_text = final_comma_text

			output += "[input[index]][comma_text]"
			index++

		return "[output][and_text][input[index]]"

//Returns list element or null. Should prevent "index out of bounds" error.
proc/listgetindex(var/list/list,index)
	if (istype(list) && list.len)
		if (isnum(index))
			if (InRange(index,1,list.len))
				return list[index]
		else if (index in list)
			return list[index]
	return

//Return either pick(list) or null if list is not of type /list or is empty
proc/safepick(list/list)
	if (!islist(list) || !list.len)
		return
	return pick(list)

//Checks if the list is empty
proc/isemptylist(list/list)
	if (!list.len)
		return TRUE
	return FALSE

//Checks for specific types in a list
/proc/is_type_in_list(var/atom/A, var/list/L)
	for (var/type in L)
		if (istype(A, type))
			return TRUE
	return FALSE

/proc/instances_of_type_in_list(var/atom/A, var/list/L)
	var/instances = FALSE
	for (var/type in L)
		if (istype(A, type))
			instances++
	return instances

//Empties the list by .Cut(). Setting lenght = FALSE has been confirmed to leak references.
proc/clearlist(var/list/L)
	if (islist(L))
		L.Cut()

//Removes any null entries from the list
proc/listclearnulls(list/list)
	if (istype(list))
		while (null in list)
			list -= null
	return

/*
 * Returns list containing all the entries from first list that are not present in second.
 * If skiprep = TRUE, repeated elements are treated as one.
 * If either of arguments is not a list, returns null
 */
/proc/difflist(var/list/first, var/list/second, var/skiprep=0)
	if (!islist(first) || !islist(second))
		return
	var/list/result = new
	if (skiprep)
		for (var/e in first)
			if (!(e in result) && !(e in second))
				result += e
	else
		result = first - second
	return result

/*
 * Returns list containing entries that are in either list but not both.
 * If skipref = TRUE, repeated elements are treated as one.
 * If either of arguments is not a list, returns null
 */
/proc/uniquemergelist(var/list/first, var/list/second, var/skiprep=0)
	if (!islist(first) || !islist(second))
		return
	var/list/result = new
	if (skiprep)
		result = difflist(first, second, skiprep)+difflist(second, first, skiprep)
	else
		result = first ^ second
	return result

//Pretends to pick an element based on its weight but really just seems to pick a random element.
/proc/pickweight(list/L)
	var/total = FALSE
	var/item
	for (item in L)
		if (!L[item])
			L[item] = TRUE
		total += L[item]

	total = rand(1, total)
	for (item in L)
		total -=L [item]
		if (total <= 0)
			return item

	return null

//Pick a random element from the list and remove it from the list.
/proc/pick_n_take(list/listfrom)
	if (listfrom.len > 0)
		var/picked = pick(listfrom)
		listfrom -= picked
		return picked
	return null

//Returns the top(last) element from the list and removes it from the list (typical stack function)
/proc/pop(list/listfrom)
	if (listfrom.len > 0)
		var/picked = listfrom[listfrom.len]
		listfrom.len--
		return picked
	return null

//Returns the next element in parameter list after first appearance of parameter element. If it is the last element of the list or not present in list, returns first element.
/proc/next_in_list(element, list/L)
	for (var/i=1, i<L.len, i++)
		if (L[i] == element)
			return L[i+1]
	return L[1]

/*
 * Sorting
 */

//Reverses the order of items in the list
/proc/reverselist(list/L)
	var/list/output = list()
	if (L)
		for (var/i = L.len; i >= 1; i--)
			output += L[i]
	return output

//Randomize: Return the list in a random order
/proc/shuffle(var/list/L)
	if (!L)
		return

	L = L.Copy()

	for (var/i=1; i<L.len; i++)
		L.Swap(i, rand(i,L.len))
	return L

//Return a list with no duplicate entries
/proc/uniquelist(var/list/L)
	. = list()
	for (var/i in L)
		. |= i

//Mergesort: divides up the list into halves to begin the sort
/proc/sortKey(var/list/client/L, var/order = TRUE)
	if (isnull(L) || L.len < 2)
		return L
	var/middle = L.len / 2 + 1
	return mergeKey(sortKey(L.Copy(0,middle)), sortKey(L.Copy(middle)), order)

//Mergsort: does the actual sorting and returns the results back to sortAtom
/proc/mergeKey(var/list/client/L, var/list/client/R, var/order = TRUE)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while (Li <= L.len && Ri <= R.len)
		var/client/rL = L[Li]
		var/client/rR = R[Ri]
		if (sorttext(rL.ckey, rR.ckey) == order)
			result += L[Li++]
		else
			result += R[Ri++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))

//Mergesort: divides up the list into halves to begin the sort
/proc/sortAtom(var/list/atom/L, var/order = TRUE)
	if (isnull(L) || L.len < 2)
		return L
	var/middle = L.len / 2 + 1
	return mergeAtoms(sortAtom(L.Copy(0,middle)), sortAtom(L.Copy(middle)), order)

//Mergsort: does the actual sorting and returns the results back to sortAtom
/proc/mergeAtoms(var/list/atom/L, var/list/atom/R, var/order = TRUE)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	if (R)
		while (Li <= L.len && Ri <= R.len)
			var/atom/rL = L[Li]
			var/atom/rR = R[Ri]
			if (sorttext(rL.name, rR.name) == order)
				result += L[Li++]
			else
				result += R[Ri++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))



/*
//Mergesort: Specifically for record datums in a list.
/proc/sortRecord(var/list/datum/data/record/L, var/field = "name", var/order = TRUE)
	if (isnull(L))
		return list()
	if (L.len < 2)
		return L
	var/middle = L.len / 2 + 1
	return mergeRecordLists(sortRecord(L.Copy(0, middle), field, order), sortRecord(L.Copy(middle), field, order), field, order)

//Mergsort: does the actual sorting and returns the results back to sortRecord
/proc/mergeRecordLists(var/list/datum/data/record/L, var/list/datum/data/record/R, var/field = "name", var/order = TRUE)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	if (!isnull(L) && !isnull(R))
		while (Li <= L.len && Ri <= R.len)
			var/datum/data/record/rL = L[Li]
			if (isnull(rL))
				L -= rL
				continue
			var/datum/data/record/rR = R[Ri]
			if (isnull(rR))
				R -= rR
				continue
			if (sorttext(rL.fields[field], rR.fields[field]) == order)
				result += L[Li++]
			else
				result += R[Ri++]

		if (Li <= L.len)
			return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))
*/



//Mergesort: any value in a list
/proc/sortList(var/list/L)
	if (L.len < 2)
		return L
	var/middle = L.len / 2 + 1 // Copy is first,second-1
	return mergeLists(sortList(L.Copy(0,middle)), sortList(L.Copy(middle))) //second parameter null = to end of list

//Mergsorge: uses sortList() but uses the var's name specifically. This should probably be using mergeAtom() instead
/proc/sortNames(var/list/L)
	var/list/Q = new()
	for (var/atom/x in L)
		Q[x.name] = x
	return sortList(Q)

/proc/mergeLists(var/list/L, var/list/R)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while (Li <= L.len && Ri <= R.len)
		if (sorttext(L[Li], R[Ri]) < 1)
			result += R[Ri++]
		else
			result += L[Li++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))


// List of lists, sorts by element[key] - for things like crew monitoring computer sorting records by name.
/proc/sortByKey(var/list/L, var/key)
	if (L.len < 2)
		return L
	var/middle = L.len / 2 + 1
	return mergeKeyedLists(sortByKey(L.Copy(0, middle), key), sortByKey(L.Copy(middle), key), key)

/proc/mergeKeyedLists(var/list/L, var/list/R, var/key)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while (Li <= L.len && Ri <= R.len)
		if (sorttext(L[Li][key], R[Ri][key]) < 1)
			// Works around list += list2 merging lists; it's not pretty but it works
			result += "temp item"
			result[result.len] = R[Ri++]
		else
			result += "temp item"
			result[result.len] = L[Li++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))


/proc/list_is_assoc(var/list/L)
	. = FALSE
	if (L.len > 0)
		var/a = L[1]
		if (istext(a) && L[a] != null)
			. = TRUE

//Mergesort: any value in a list, preserves key=value structure
/proc/sortAssoc(var/list/L)
	if (L.len < 2)
		return L
	var/middle = L.len / 2 + 1 // Copy is first,second-1
	return mergeAssoc(sortAssoc(L.Copy(0,middle)), sortAssoc(L.Copy(middle))) //second parameter null = to end of list

/proc/mergeAssoc(var/list/L, var/list/R)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while (Li <= L.len && Ri <= R.len)
		if (sorttext(L[Li], R[Ri]) < 1)
			result += R&R[Ri++]
		else
			result += L&L[Li++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))

// Macros to test for bits in a bitfield. Note, that this is for use with indexes, not bit-masks!
#define BITTEST(bitfield,index)  ((bitfield)  &   (1 << (index)))
#define BITSET(bitfield,index)   (bitfield)  |=  (1 << (index))
#define BITRESET(bitfield,index) (bitfield)  &= ~(1 << (index))
#define BITFLIP(bitfield,index)  (bitfield)  ^=  (1 << (index))

//Converts a bitfield to a list of numbers (or words if a wordlist is provided)
/proc/bitfield2list(bitfield = FALSE, list/wordlist)
	var/list/r = list()
	if (istype(wordlist,/list))
		var/max = min(wordlist.len,16)
		var/bit = TRUE
		for (var/i=1, i<=max, i++)
			if (bitfield & bit)
				r += wordlist[i]
			bit = bit << 1
	else
		for (var/bit=1, bit<=65535, bit = bit << 1)
			if (bitfield & bit)
				r += bit

	return r

// Returns the key based on the index
/proc/get_key_by_index(var/list/L, var/index)
	var/i = TRUE
	for (var/key in L)
		if (index == i)
			return key
		i++
	return null

// Returns the key based on the index
/proc/get_key_by_value(var/list/L, var/value)
	for (var/key in L)
		if (L[key] == value)
			return key

/proc/count_by_type(var/list/L, type)
	var/i = FALSE
	for (var/T in L)
		if (istype(T, type))
			i++
	return i

//Don't use this on lists larger than half a dozen or so
/proc/insertion_sort_numeric_list_ascending(var/list/L)
	//world.log << "ascending len input: [L.len]"
	var/list/out = list(pop(L))
	for (var/entry in L)
		if (isnum(entry))
			var/success = FALSE
			for (var/i=1, i<=out.len, i++)
				if (entry <= out[i])
					success = TRUE
					out.Insert(i, entry)
					break
			if (!success)
				out.Add(entry)

	//world.log << "	output: [out.len]"
	return out

/proc/insertion_sort_numeric_list_descending(var/list/L)
	//world.log << "descending len input: [L.len]"
	var/list/out = insertion_sort_numeric_list_ascending(L)
	//world.log << "	output: [out.len]"
	return reverselist(out)

/proc/dd_sortedObjectList(var/list/L, var/cache=list())
	if (L.len < 2)
		return L
	var/middle = L.len / 2 + 1 // Copy is first,second-1
	return dd_mergeObjectList(dd_sortedObjectList(L.Copy(0,middle), cache), dd_sortedObjectList(L.Copy(middle), cache), cache) //second parameter null = to end of list

/proc/dd_mergeObjectList(var/list/L, var/list/R, var/list/cache)
	var/Li=1
	var/Ri=1
	var/list/result = new()
	while (Li <= L.len && Ri <= R.len)
		var/LLi = L[Li]
		var/RRi = R[Ri]
		var/LLiV = cache[LLi]
		var/RRiV = cache[RRi]
		if (!LLiV)
			LLiV = LLi:dd_SortValue()
			cache[LLi] = LLiV
		if (!RRiV)
			RRiV = RRi:dd_SortValue()
			cache[RRi] = RRiV
		if (LLiV < RRiV)
			result += L[Li++]
		else
			result += R[Ri++]

	if (Li <= L.len)
		return (result + L.Copy(Li, FALSE))
	return (result + R.Copy(Ri, FALSE))

// Insert an object into a sorted list, preserving sortedness
/proc/dd_insertObjectList(var/list/L, var/O)
	var/min = TRUE
	var/max = L.len
	var/Oval = O:dd_SortValue()

	while (1)
		var/mid = min+round((max-min)/2)

		if (mid == max)
			L.Insert(mid, O)
			return

		var/Lmid = L[mid]
		var/midval = Lmid:dd_SortValue()
		if (Oval == midval)
			L.Insert(mid, O)
			return
		else if (Oval < midval)
			max = mid
		else
			min = mid+1

/*
proc/dd_sortedObjectList(list/incoming)
	/*
	   Use binary search to order by dd_SortValue().
	   This works by going to the half-point of the list, seeing if the node in
	   question is higher or lower cost, then going halfway up or down the list
	   and checking again. This is a very fast way to sort an item into a list.
	*/
	var/list/sorted_list = new()
	var/low_index
	var/high_index
	var/insert_index
	var/midway_calc
	var/current_index
	var/current_item
	var/current_item_value
	var/current_sort_object_value
	var/list/list_bottom

	var/current_sort_object
	for (current_sort_object in incoming)
		low_index = TRUE
		high_index = sorted_list.len
		while (low_index <= high_index)
			// Figure out the midpoint, rounding up for fractions.  (BYOND rounds down, so add TRUE if necessary.)
			midway_calc = (low_index + high_index) / 2
			current_index = round(midway_calc)
			if (midway_calc > current_index)
				current_index++
			current_item = sorted_list[current_index]

			current_item_value = current_item:dd_SortValue()
			current_sort_object_value = current_sort_object:dd_SortValue()
			if (current_sort_object_value < current_item_value)
				high_index = current_index - 1
			else if (current_sort_object_value > current_item_value)
				low_index = current_index + 1
			else
				// current_sort_object == current_item
				low_index = current_index
				break

		// Insert before low_index.
		insert_index = low_index

		// Special case adding to end of list.
		if (insert_index > sorted_list.len)
			sorted_list += current_sort_object
			continue

		// Because BYOND lists don't support insert, have to do it by:
		// TRUE) taking out bottom of list, 2) adding item, 3) putting back bottom of list.
		list_bottom = sorted_list.Copy(insert_index)
		sorted_list.Cut(insert_index)
		sorted_list += current_sort_object
		sorted_list += list_bottom
	return sorted_list
*/

proc/dd_sortedtextlist(list/incoming, case_sensitive = FALSE)
	// Returns a new list with the text values sorted.
	// Use binary search to order by sortValue.
	// This works by going to the half-point of the list, seeing if the node in question is higher or lower cost,
	// then going halfway up or down the list and checking again.
	// This is a very fast way to sort an item into a list.
	var/list/sorted_text = new()
	var/low_index
	var/high_index
	var/insert_index
	var/midway_calc
	var/current_index
	var/current_item
	var/list/list_bottom
	var/sort_result

	var/current_sort_text
	for (current_sort_text in incoming)
		low_index = TRUE
		high_index = sorted_text.len
		while (low_index <= high_index)
			// Figure out the midpoint, rounding up for fractions.  (BYOND rounds down, so add TRUE if necessary.)
			midway_calc = (low_index + high_index) / 2
			current_index = round(midway_calc)
			if (midway_calc > current_index)
				current_index++
			current_item = sorted_text[current_index]

			if (case_sensitive)
				sort_result = sorttextEx(current_sort_text, current_item)
			else
				sort_result = sorttext(current_sort_text, current_item)

			switch(sort_result)
				if (1)
					high_index = current_index - 1	// current_sort_text < current_item
				if (-1)
					low_index = current_index + 1	// current_sort_text > current_item
				if (0)
					low_index = current_index		// current_sort_text == current_item
					break

		// Insert before low_index.
		insert_index = low_index

		// Special case adding to end of list.
		if (insert_index > sorted_text.len)
			sorted_text += current_sort_text
			continue

		// Because BYOND lists don't support insert, have to do it by:
		// TRUE) taking out bottom of list, 2) adding item, 3) putting back bottom of list.
		list_bottom = sorted_text.Copy(insert_index)
		sorted_text.Cut(insert_index)
		sorted_text += current_sort_text
		sorted_text += list_bottom
	return sorted_text


proc/dd_sortedTextList(list/incoming)
	var/case_sensitive = TRUE
	return dd_sortedtextlist(incoming, case_sensitive)


/datum/proc/dd_SortValue()
	return "[src]"

/*
/obj/machinery/dd_SortValue()
	return "[sanitize_old(name)]"
*/

/proc/subtypesof(prototype)
	return (typesof(prototype) - prototype)

//creates every subtype of prototype (excluding prototype) and adds it to list L.
//if no list/L is provided, one is created.
/proc/init_subtypes(prototype, list/L)
	if (!istype(L))	L = list()
	for (var/path in subtypesof(prototype))
		L += new path()
	return L

//Move a single element from position fromIndex within a list, to position toIndex
//All elements in the range [1,toIndex) before the move will be before the pivot afterwards
//All elements in the range [toIndex, L.len+1) before the move will be after the pivot afterwards
//In other words, it's as if the range [fromIndex,toIndex) have been rotated using a <<< operation common to other languages.
//fromIndex and toIndex must be in the range [1,L.len+1]
//This will preserve associations ~Carnie
/proc/moveElement(list/L, fromIndex, toIndex)
	if(fromIndex == toIndex || fromIndex+1 == toIndex)	//no need to move
		return
	if(fromIndex > toIndex)
		++fromIndex	//since a null will be inserted before fromIndex, the index needs to be nudged right by one

	L.Insert(toIndex, null)
	L.Swap(fromIndex, toIndex)
	L.Cut(fromIndex, fromIndex+1)


//Move elements [fromIndex,fromIndex+len) to [toIndex-len, toIndex)
//Same as moveElement but for ranges of elements
//This will preserve associations ~Carnie
/proc/moveRange(list/L, fromIndex, toIndex, len=1)
	var/distance = abs(toIndex - fromIndex)
	if(len >= distance)	//there are more elements to be moved than the distance to be moved. Therefore the same result can be achieved (with fewer operations) by moving elements between where we are and where we are going. The result being, our range we are moving is shifted left or right by dist elements
		if(fromIndex <= toIndex)
			return	//no need to move
		fromIndex += len	//we want to shift left instead of right

		for(var/i=0, i<distance, ++i)
			L.Insert(fromIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(toIndex, toIndex+1)
	else
		if(fromIndex > toIndex)
			fromIndex += len

		for(var/i=0, i<len, ++i)
			L.Insert(toIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(fromIndex, fromIndex+1)


//Move elements from [fromIndex, fromIndex+len) to [toIndex, toIndex+len)
//Move any elements being overwritten by the move to the now-empty elements, preserving order
//Note: if the two ranges overlap, only the destination order will be preserved fully, since some elements will be within both ranges ~Carnie
/proc/swapRange(list/L, fromIndex, toIndex, len=1)
	var/distance = abs(toIndex - fromIndex)
	if(len > distance)	//there is an overlap, therefore swapping each element will require more swaps than inserting new elements
		if(fromIndex < toIndex)
			toIndex += len
		else
			fromIndex += len

		for(var/i=0, i<distance, ++i)
			L.Insert(fromIndex, null)
			L.Swap(fromIndex, toIndex)
			L.Cut(toIndex, toIndex+1)
	else
		if(toIndex > fromIndex)
			var/a = toIndex
			toIndex = fromIndex
			fromIndex = a

		for(var/i=0, i<len, ++i)
			L.Swap(fromIndex++, toIndex++)

//replaces reverseList ~Carnie
/proc/reverseRange(list/L, start=1, end=0)
	if(L.len)
		start = start % L.len
		end = end % (L.len+1)
		if(start <= 0)
			start += L.len
		if(end <= 0)
			end += L.len + 1

		--end
		while(start < end)
			L.Swap(start++,end--)

	return L

#define listequal(A, B) (A.len == B.len && !length(A^B))


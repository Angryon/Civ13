////////////////////////////////////////////////////////////////////////////
///////////////////////////////////Companies////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/proc/create_company()
	set name = "Create Company"
	set category = "Faction"
	var/mob/living/carbon/human/U

	if (istype(src, /mob/living/carbon/human))
		U = src
	else
		return
	if (map.civilizations == TRUE)
		var/choosename = russian_to_cp1251(input(U, "Choose a name for the company:") as text|null)
		create_company_pr(choosename)
		return
	else
		U << "<span class='danger'>You cannot create a company in this map.</span>"
		return

/mob/living/carbon/human/proc/create_company_pr(var/newname = "none")
	if (!ishuman(src))
		return
	var/mob/living/carbon/human/H = src
	for(var/i = 1, i <= map.custom_company_nr.len, i++)
		if (map.custom_company_nr[i] == newname || newname == "Global")
			usr << "<span class='danger'>That company already exists. Choose another name.</span>"
			return
	if (newname != null && newname != "none")
		var/choosecolor1 = "#000000"
		var/choosecolor2 = "#FFFFFF"
		choosecolor1 = input(H, "Choose the main hex color (without the #):", "Color" , "000000")
		if (choosecolor1 == null || choosecolor1 == "")
			return
		else
			choosecolor1 = uppertext(choosecolor1)
			if (lentext(choosecolor1) != 6)
				return
			var/list/listallowed = list("A","B","C","D","E","F","1","2","3","4","5","6","7","8","9","0")
			for (var/i = 1, i <= 6, i++)
				var/numtocheck = 0
				if (i < 6)
					numtocheck = copytext(choosecolor1,i,i+1)
				else
					numtocheck = copytext(choosecolor1,i,0)
				if (!(numtocheck in listallowed))
					return
			choosecolor1 = addtext("#",choosecolor1)

		choosecolor2 = input(H, "Choose the secondary/background hex color (without the #):", "Color" , "FFFFFF")
		if (choosecolor2 == null || choosecolor2 == "")
			return
		else
			choosecolor2 = uppertext(choosecolor2)
			if (lentext(choosecolor2) != 6)
				return
			var/list/listallowed = list("A","B","C","D","E","F","1","2","3","4","5","6","7","8","9","0")
			for (var/i = 1, i <= 6, i++)
				var/numtocheck = 0
				if (i < 6)
					numtocheck = copytext(choosecolor2,i,i+1)
				else
					numtocheck = copytext(choosecolor2,i,0)
				if (!(numtocheck in listallowed))
					return
			choosecolor2 = addtext("#",choosecolor2)
		map.custom_company_nr += newname
		var/list/newnamev = list("[newname]" = list(list(H,100,0)))
		map.custom_company += newnamev
		map.custom_company_colors += list("[newname]" = list(choosecolor1,choosecolor2))
		usr << "<big>You now own <b>100%</b> of the new company [newname].</big>"
		return
	else
		return

/mob/living/carbon/human/proc/transfer_company_stock()
	set name = "Transfer Company Stock"
	set category = "Faction"
	var/mob/living/carbon/human/H
	if (istype(src, /mob/living/carbon/human))
		H = src
	else
		return
	if (map.civilizations == TRUE)
		var/found = FALSE
		var/list/currlist = list()
		var/list/currlist_ind = list("Cancel")
		for (var/cname in map.custom_company_nr)
			for (var/i = 1, i <= map.custom_company[cname].len, i++)
				if (map.custom_company[cname][i][1] == H)
					currlist += list("[cname]" = list(map.custom_company[cname][i][2]))
					currlist_ind += cname
					found = TRUE
		if (!found)
			usr << "You do not own any stocks."
			return
		else
			var/compchoice = WWinput(H, "Which company to transfer stock ownership?", "Stock Transfer", "Cancel", currlist_ind)
			if (compchoice == "Cancel")
				return
			else
				var/compchoice_amt = input(H, "You own [currlist[compchoice][1]]% of [compchoice]. How much do you want to transfer? (1 to [currlist[compchoice][1]])") as num|null
				compchoice_amt = round(compchoice_amt)
				if (compchoice_amt > currlist[compchoice][1])
					compchoice_amt = currlist[compchoice][1]
				else if (compchoice_amt <= 0)
					return
				var/list/closemobs = list("Cancel")
				for (var/mob/living/carbon/human/M in range(4,loc))
					if (M.stat != DEAD)
						closemobs += M
				var/choice2 = WWinput(usr, "Who to transfer the stocks to?", "Stock Transfer", "Cancel", closemobs)
				if (choice2 == "Cancel")
					return
				else
					var/mob/living/carbon/human/CM = choice2
					for(var/l=1, l <= map.custom_company[compchoice].len, l++)
						if (map.custom_company[compchoice][l][1] == H)
							var/currb = map.custom_company[compchoice][l][2]
							map.custom_company[compchoice][l][2] = currb-compchoice_amt

					for(var/l=1,  l <= map.custom_company[compchoice].len, l++)
						if (map.custom_company[compchoice][l][1] == CM)
							var/currb = map.custom_company[compchoice][l][2]
							map.custom_company[compchoice][l][2] = currb+compchoice_amt
							return
					map.custom_company[compchoice] += list(list(CM,compchoice_amt,0))
					H << "<big>Transfered [compchoice_amt]% of [compchoice] to [CM].</big>"
					CM << "<big>You received [compchoice_amt]% of [compchoice] from [H].</big>"
					return
	else
		usr << "<span class='danger'>You cannot transfer company ownership on this map.</span>"
		return

//searches company members for a player
/proc/find_company_member(var/mob/living/carbon/human/H, var/company)
	if (!map || !H || !company)
		return FALSE

	for(var/i=1,i<=map.custom_company[company].len,i++)
		if (map.custom_company[company][i][1] == H)
			return TRUE

	return FALSE

//for automated transfers e.g. stock market
/mob/living/carbon/human/proc/transfer_stock_proc(var/companyname, var/stock, var/mob/living/carbon/human/target)
	if (!companyname || !stock || !target)
		return

	for(var/l=1, l <= map.custom_company[companyname].len, l++)
		if (map.custom_company[companyname][l][1] == src)
			var/currb = map.custom_company[companyname][l][2]
			map.custom_company[companyname][l][2] = currb-stock

	for(var/l=1,  l <= map.custom_company[companyname].len, l++)
		if (map.custom_company[companyname][l][1] == target)
			var/currb = map.custom_company[companyname][l][2]
			map.custom_company[companyname][l][2] = currb+stock
			return
	map.custom_company[companyname] += list(list(target,stock,0))
	src << "<big>Transfered [stock]% of [companyname] to [target].</big>"
	target << "<big>You received [stock]% of [companyname] from [src].</big>"
	return
*! version 1.0.0  27Apr2023 
capture program drop labmake 
program define labmake 
	
	syntax name, Values(varlist) Labels(varlist) [add modify replace nofix show] 
	
	qui{ 		
		** use frames or preserve?
		if c(version) >= 16 {
			tempfile data
			save `data', replace
			
			cap frame create frame_lm  
			local fr frame frame_lm: 
			`fr' use `values' `labels' using `data', clear
			}
		else { 
			preserve
			keep `values' `labels'
		}
	  
		** check variable formats
		`fr' cap confirm numeric variable `values' 
		if _rc!=0  {
			n di as txt `"Note: `values' is not numeric"' 
			n di as txt `" -> all non-numeric values of `values' will be ignored!"'
			`fr' destring `values', force replace
		} 
		`fr' cap confirm string variable `labels' 
		if _rc!=0 {
			n di as txt `"Note: `labels' is not string"'
			`fr' tostring `labels', force replace
		}
		
		** discard missing values and count the rows
		`fr' drop if `values' ==.		
		`fr' local N = _N 

		** read-in the values and labels, one row at a time
		forvalues r = 1/`N' {
			`fr' local rv = `values'[`r']
			`fr' local rl = `labels'[`r']
							
			if strrpos(`"`rl'"',`"""') == 0 local lm `lm' `rv' "`rl'"
			else local lm `lm' `rv' `"`rl'"'
		}
		
		** restore the original data, or scrap the auxiliary frame
		if (c(version) < 16) restore
		else frame drop frame_lm
		
		** define the label
		label define `namelist' `lm', `replace' `add' `modify' `nofix'  
		
		** print-out
		n di "Finished!"
		if "`show'"!="" n label list `namelist' 		
	}
end
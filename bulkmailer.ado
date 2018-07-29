*! version 1.0 	 6 December 2016	Author: Iain Snoddy, iainsnoddy@gmail.com

/*
This program intakes a .dta file and iteratively emails each
address given in the specified column. Additional information provided 
in other columns but in the same row can be included in the email body or 
can specify the email attachment to be included.
*/

program define bulkmailer
	version 12
	syntax anything(name=datafile)   , [  FOlderc(string) FRom(string) Par(numlist) ///
				html(string) s(string) Att(string) Email(string) Insert(namelist) ///
				SMTPPort(string) SMTPServer(string) bcc(string) cc(string) b(string) ///
				Test(string) nossl ]

				
	if "`email'"==""{
		di as error "The name of the variable in which email addresses"
		di as error "are stored must be named"
		exit
	}
	
	if "`b'"=="" & "`insert'"!=""{
		di as error "insert() cannot be spcified when the email body is empty"
		exit
	}
	
	if "`b'"=="" & "`html'"!=""{
		di as error "html() cannot be spcified when the email body is empty"
		exit
	}
	
	if "`b'"=="" & "`par'"!=""{
		di as error "par() cannot be spcified when the email body is empty"
		exit
	}	
	
	if "`b'"=="" & "`s'"=="" & "`att'"==""{
		di as error "At least one option of att(), b() or s() must be specified"
	}
	
	if "`folderc'"=="" local folderc `c(pwd)'	

	pscred username passname, folderc("`folderc'") del 
	
	capture noisily{
	
		if "`datafile'"!="dta" use `datafile'.dta,clear
		qui describe `email'
		local num=r(N)
	
		if "`test'"!=""{
			local body "`b'"
			if "`insert'"!=""{
				local j=1
				foreach var of varlist `insert'{
					local input=`var'[1]
					local body=subinstr("`body'", "@insert`j'","`input'",.)
					local j=`j'+1
				}
			}
			else local body "`b'"
			
			local mailto=`email'[1]
			if "`att'"!="" local att=`att'[1]
			
			disp "Intended recipient of test email: `mailto' "
			
			winmail `test', s("`s'") b("`body'") html("`html'") par("`par'") ///
			psloc("`folderc'") from("`from'") ufile("`folderc'\username") ///
			pfile("`folderc'\passname") att("`att'") cc("`cc'") bcc("`bcc'") `nossl'
			
			display "Was the test email OK? If yes, type [Y] to continue. If not, type [N] to exit the program." _request(yn)
			if "$yn"=="N" | "$yn"=="[N]" {
				display "The files storing your username and password will now be deleted and the program will exit"
				winexec powershell.exe Remove-Item "`folderc'\\username.txt"	
				winexec powershell.exe Remove-Item "`folderc'\\passname.txt"
				exit
			}
			else display "Sweet! The program will now continue running"
		}
		
		forvalues i=1/`num'{
			local body "`b'"
			if "`insert'"!=""{
				local j=1
				foreach var of varlist `insert'{
					local input=`var'[`i']
					local body=subinstr("`body'", "@insert`j'","`input'",.)
					local j=`j'+1
				}
			}
			else local body "`b'"
			
			local mailto=`email'[`i']
			if "`att'"!="" local attdoc=`att'[`i']
			
			winmail `mailto', s("`s'") b("`body'") html("`html'") par("`par'") ///
			psloc("`folderc'") from("`from'") ufile("`folderc'\username") ///
			pfile("`folderc'\passname") att("`attdoc'") cc("`cc'") bcc("`bcc'") `nossl'
			sleep 5000
			
		}
		
		sleep 5000
		winexec powershell.exe Remove-Item "`folderc'\\username.txt"	
		winexec powershell.exe Remove-Item "`folderc'\\passname.txt"
		
	}
	if _rc!=0{
		winexec powershell.exe Remove-Item "`folderc'\\username.txt"	
		winexec powershell.exe Remove-Item "`folderc'\\passname.txt"	
	}
	
end

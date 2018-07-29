{smcl}
{* *! version 1.2.1  8dec2016}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help bulkmailer"}{...}
{viewerjumpto "Syntax" "bulkmailer##syntax"}{...}
{viewerjumpto "Description" "bulkmailer##description"}{...}
{viewerjumpto "Options" "bulkmailer##options"}{...}
{viewerjumpto "Remarks" "bulkmailer##remarks"}{...}
{viewerjumpto "Examples" "bulkmailer##examples"}{...}
{title:Title}

{phang}
{bf:bulkmailer} {hline 2} Sends emails to many recipients using information stored in .dta file.

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:bulkmailer}
{it:filename}{cmd: email(column_name) [,}{it:options}]

{synoptset 25 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt s(subject)}}email subject{p_end}
{synopt:{opt b(body)}}email body{p_end}
{synopt:{opt fo:lderc(dta_folder)}}folder where credentials will be stored; default location is the current working directory{p_end}
{synopt:{opt e:mail(column_name)}}name of column in .dta listing emails addresses{p_end}
{synopt:{opt a:tt(column_name)}}name of column in .dta giving full path to files{p_end}
{synopt:{opt smtpp:ort(smtp port)}}smtp port; default 587 {p_end}
{synopt:{opt smtps:server(smtp server)}}smtp server address; default smtp.gmail.com{p_end}
{synopt:{opt fr:om(name)}}name of sender; default is email username {p_end}
{synopt:{opt cc(cc_recipient)}}email address of person cc'd on email{p_end}
{synopt:{opt bcc(bcc_recipient)}}email address of person bcc'd on email{p_end}
{synopt:{opt nossl}}turns off ssl; by default ssl encryption is used{p_end}
{synopt:{opt t:est(email_address)}}sends a test before sending emails{p_end}
{synopt:{opt html(email html)}}html to be used in email body{p_end}
{synopt:{opt p:ar(paragraphs)}}paragraph breaks in email body{p_end}
{synopt:{opt i:nsert(column_namelist)}}namelist of columns in .dta file with text to be inserted into the email body{p_end}
{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:bulkmailer} sends many email messages using data stored in a .dta file. Users can send personalised
emails to many recipients, including personalised attachments, and personal information in the body of
the email. Emails will be formatted similarly, but each recipients email will be personalised using 
information stored in the columns of a .dta file, where each row represents an email recipient.


{marker options}{...}
{title:Options}

{dlgtab:Main}

{phang}				
{opt s(subject)} is the email subject which will be the same for all recipients.

{phang}				
{opt b(body)} specifies the body of the email to be sent. The body should be inputted as a single string with 
	blocks of text being parsed by "|". Each substring separated by "|" will be numbered and modified using
	html wrappers if specified. Text inputted as "line1 | line2 | line3" will be treated as 3 separate blocks
	of text and numbered "1,2,3". Text included in .dta columns listed in {opt insert} can be included in the 
	email body. To include information form the .dta file refer to each insert as "@insertj" in the email body,
	where "j" represents the order of inserted information in {opt insert}. For example, if information from
	3 columns is to be included in the body of the email these would be referenced in the email body as 
	"Hello @insert1 | how are you doing? | You got @insert2  on the assignment | @insert3".

{phang}				
{opt folderc(dta_folder)} is the folder where captured credentials and the .ps1 file will be stored.

{phang}				
{opt email(column_name)} is the name of the column storing each email address. 

{phang}				
{opt att(column_name)} is the name of the column with listing the full path of attachments to be included.

{phang}				
{opt smtpport(smtp port)} gives the smtp port number. By default it is set to that used by gmail.

{phang}				
{opt smtpsserver(smtp server)} gives the smtp server address which by default is the gmail smtp server.

{phang}				
{opt from(name)} is the name of the sender which by default is not provided.

{phang}				
{opt cc(cc_recipient)} is the email address included as a cc to the email. Only a single cc recipient can be included.

{phang}				
{opt bcc(bcc_recipient)} is the email address included as a bcc to the email. Only a single cc recipient can be included.

{phang}				
{opt  nossl} specifies that the Secure Sockets Layer (SSL) to establish a connection is not used. 

{phang}				
{opt  test(email_address)} sends a test email prior to running the .do file. This allows users to know in 
advance that emails are being sent correctly and that the email is formatted as desired. A test email will be sent 
to the recipient which contains the email body to be sent to the individual listed first in the .dta file.
Stata will then request users interact with the console. Specifically users must enter on the console whether the email was
recieved successfully or not. If no email is received then the program will exit without running and any inputted 
credentials will be deleted. Users should note that depending on the email service used, emails may arrive with delay.
The email address provided here must differ from the senders email address.

{phang}				
{opt html(email html)} provides the html to be included in the email. The html provided modifies the text inputted in 
	in {it:body}. As each block of text parsed by "|" in {it:body} is numbered, html should be provided as wrappers
	around these numbers. Users should input a string where html wrappers are placed around numbers, with each number 
	representing a substring of {it:body}. For example "<i>1 <b>2</b></i> 3 4" makes all text in substrings
	1 and 2 italic and text in substring 2 bold. If {opt html} is specified it must include a number for
	every substring. If there are 4 inputted substrings and {opt html} takes input "<b> 1 </b> 2 3" then
	the fourth string will be missing from the email. Creating paragraphs can be done using {opt html} 
	or using {opt par}.

{phang}				
{opt par(paragraphs)} provides paragraph breaks between substrings parsed by "|" in {it:body}. The input to
	this option should take the format of a numbered list, for example par(1 3 5) creates a new paragraph 
	following substrings 1,3 and 5.

{phang}				
{opt insert(column_namelist)} lists the names of the columns storing information to be included in the body of the
email. For example if "insert(name score message)" is given then information from column name will be the first insert
included in the specified location in the email body, score will be the second and message the third. This means 
information stored in "name" will be treated as "@insert1", information in "score" as "@insert2" and information in 
"message" as "@insert3".


{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:bulkmailer} sends multiple emails sharing a similar structure but with information tailored to
each recipieint. Emails are sent via repeated calls to the {bf:{help winmail:winmail}} program. Users 
can customize emails by paragraphing and including html. All personal information along with the recipients email 
addresses must be inputted as a .dta file.

{pstd}
When the program begins users will be asked to input their email credentials. A pop-up window will appear and 
ask for users to input their credentials. The files storing the credentials will be deleted upon completion. 
Users credentials are captured using {bf:{help pscred:pscred}}. More information on this process is available 
in the documentation of {bf:{help pscred:pscred}} and {bf:{help winmail:winmail}}.

{pstd}
It is possible to send a test email before sending all emails which will send an email to a specified
email account identical to that which would be sent to the email address in the first row of the .dta file. 
Users have the option to exit the program at this point if the email either does not arrive or is not
formatted correctly. 

{pstd}
As this program makes use of windows powershell through {bf:{help winmail:winmail}} it can only be used 
on the windows operating system. Users should read the {bf:{help winmail:winmail}} documentation to ensure
that windows powershell has been granted sufficient privlidges to perform this task.

{pstd}
By default smtp settings are set to for gmail.com email accounts. Users should see the documentation for 
{bf:{help winmail:winmail}} for more information on using other email accounts.

{pstd}
{cmd:bulkmailer} requires {bf:{help pscred:pscred}} and {bf:{help winmail:winmail}} be installed. Additionally,
{bf:{help winmail:winmail}} requires that {bf:{help tknz:tknz}} be installed.


{marker examples}{...}
{title:Examples}

{pstd}{bf:Example 1: Sending the same email to all recipients}

{pstd} If we have a .dta file which lists email recipients as follows:{p_end}

{phang2}{space 12} {bf:Email_Ad }{p_end}
{phang2}{space 12} person1@email.com {p_end}
{phang2}{space 12} person2@email.com {p_end}
{phang2}{space 12} person3@email.com {p_end}

{pstd} Using {cmd:bulkmailer} we can email each person in turn. {p_end}

{pstd} To send a simple message when the .dta file is currently loaded {p_end}
{phang2}{cmd:. bulkmailer dta, email(Email_Ad)}{p_end}

{pstd} To send a simple message using a file not loaded {p_end}
{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(hello)}{p_end}

{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(hello) fr(me)}{p_end}

{phang2}{cmd:. bulkmailer C:\Users\emails.dta, e(Email_Ad) s(hello) b(hello there!) }{p_end}

{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(hello) b(hello there!) cc(me@email.com) }{p_end}

{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(hello) b(hello there!) test(me2@email.com) }{p_end}

{pstd} To send more detailed messages using html users should see the documentation for {bf:{help winmail:winmail}} 
and the examples provided.


{pstd}{bf:Example 2: Sending the same email but a unique attachment}

{pstd}To send a unique attachment to each individual our .dta file must stored the full path to the file to be attached
for each recipient. Our .dta file must look like:{p_end}
{p2colset 20 50 0 0}
{phang2}{space 12} {bf:Email_Ad} {space 12} {bf:Attach} {p_end}
{phang2}{space 12} person1@email.com {space 3} C:\Users\att1.pdf {p_end}
{phang2}{space 12} person2@email.com {space 3} C:\Users\att2.pdf {p_end}
{phang2}{space 12} person3@email.com {space 3} C:\Users\att3.pdf {p_end}

{pstd} We can then email each person using: {p_end}
{phang2}{cmd:. bulkmailer C:\Users\emails.dta, e(Email_Ad) a(Attach) s(assignment) b(Please find attachment your assignment)}{p_end}


{pstd}{bf:Example 3: Adding unique text to each email}

{pstd} Suppose we would like to send the following email to each individual with blanks filled in differently for each recipient: {p_end}

{phang2} Dear ______, 	{p_end}
{phang2} You scored ______ on the final exam.	{p_end}
{phang2} Please contact your TA at __________ 	{p_end}

{pstd} To do this out .dta file must have a column representing the text to be inputted in each blank. The
following form for the .dta file would accomplish this: {p_end}

{phang2}{space 12} {bf:Email_Ad} 		{space 12}	{bf:Name} {space 4}	{bf:Score} {space 4}	{bf:ta_email}		{p_end}
{phang2}{space 12} person1@email.com 	{space 3}	name1 {space 3}	grade1 {space 3}	ta1@email.com	{p_end}
{phang2}{space 12} person2@email.com 	{space 3}	name2 {space 3}	grade2 {space 3}	ta1@email.com	{p_end}
{phang2}{space 12} person3@email.com 	{space 3}	name3 {space 3}	grade3 {space 3}	ta2@email.com	{p_end}

{pstd} To send this email we would run:{p_end}
{phang2}{cmd:. local body "Dear @insert1, | You scored @insert2 on the final exam. | Please contact your TA at @insert3"}{p_end}
{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(exame) b(`body') insert(Name Score ta_email) par(1 2)}{p_end}

{pstd} To send the same email but with the grade made bold we would run:{p_end}
{phang2}{cmd:. local body "Dear @insert1, | You scored | @insert2 | on the final exam. | Please contact your TA at @insert3"}{p_end}
{phang2}{cmd:. bulkmailer C:\Users\emails.dta, email(Email_Ad) s(exame) b(`body') insert(Name Score ta_email) par(1 4) html(1 2 <b>3</b> 4 5) }{p_end}

{marker author}{...}
{title:Author}

{pstd}Iain Snoddy{p_end}
{pstd}iainsnoddy@gmail.com{p_end}



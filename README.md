# bulkmailer

Stata module that sends many similarly formatted emails to different email addresses. This program allows users to send emails to many users replacing keywords or lines of text for each user. The information to be substituted for each email recipient must be stored in a .dta file, with each column representing various inputs to the program.

*Suggested use*: bulkmailer was created so that I could send individual emails to an entire class with their individual grade inputted into the email body. This program achieves this task easily and allows for much more flexible emails to be sent. For instance, users could provide personalized comments to each student.

*Dependencies*: pscred, tknz, winmail and Windows Powershell be installed on the users system

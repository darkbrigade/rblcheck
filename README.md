# RBLCHECK
## RBL Check script for Servers IP List

# How does it work?
this is a simple script that uses rblcheck binaries to check wheter standard input ips are listed in the blacklists.

## Variables
Filepath is where you store your Servers ip as a list<br/>
maxip is the total amount of servers you want to check<br/>
realcount is the value we use for the loop<br/>
count is the value that we start our loop with our array<br/>
ip is the value we use for each loop to check in RBL<br/>
RBLReport is the temprorary file that we store result of check for reporting via email<br/>
RBLCheck is the temprorary file that we store check results<br/>

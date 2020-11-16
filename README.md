# RBLCHECK
## RBL Check script for Servers IP List

# How does it work?
this is a simple script that uses rblcheck binaries to check wheter standard input ips are listed in the blacklists.

## Variables
Filepath is where you store your Servers ip as a list
maxip is the total amount of servers you want to check
realcount is the value we use for the loop
count is the value that we start our loop with our array
ip is the value we use for each loop to check in RBL
RBLReport is the temprorary file that we store result of check for reporting via email
RBLCheck is the temprorary file that we store check results

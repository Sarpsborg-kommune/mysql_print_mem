#!/bin/bash
# Source:  https://tech.labelleassiette.com/how-to-reduce-the-memory-usage-of-mysql-61ea7d1a9bd
#          Thomas Florelli
# Credits: Eduardo Franceschi

# Edit mysql to include authentication
mysql -u root -p -e "show variables; show status" | awk '
{
VAR[$1]=$2
}
END {

}'
#!/bin/sh
#
# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38451
# Finding ID:	V-38451
# Version:	RHEL-06-000040
# Finding Level:	Medium
#
#     The /etc/passwd file must be group-owned by root. The "/etc/passwd" 
#     file contains information about the users that are configured on the 
#     system. Protection of this file is critical for system security.
#
############################################################

# Standard outputter function
diag_out() {
   echo "${1}"
}

diag_out "----------------------------------"
diag_out "STIG Finding ID: V-38450"
diag_out "  Ensure passwd file is owned as"
diag_out "  the root group"
diag_out "----------------------------------"


# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38477
# Finding ID:	V-38477
# Version:	
# Finding Level:	Medium
#
#     Users must not be able to change passwords more than once every 24 
#     hours. Setting the minimum password age protects against users 
#     cycling back to a favorite password after satisfying the password 
#     reuse requirement.
#
############################################################

script_V38477-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38477.sh

file_V38477:
  file.replace:
  - name: /etc/login.defs
  - pattern: "^PASS_MIN_DAYS.*$"
  - repl: "PASS_MIN_DAYS	1"


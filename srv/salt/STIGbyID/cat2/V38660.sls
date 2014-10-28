# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38660
# Finding ID:	V-38660
# Version:	
# Finding Level:	Medium
#
#     The snmpd service must use only SNMP protocol version 3 or newer. 
#     Earlier versions of SNMP are considered insecure, as they potentially 
#     allow unauthorized access to detailed system management information.
#
############################################################


script_V38660-describe:
  cmd.script:
  - source: salt://STIGbyID/cat2/files/V38660.sh

{% if not salt['pkg.version']('net-snmp') %}
cmd_V38660-notice:
  cmd.run:
  - name: 'echo "Info: SNMP packages not installed - nothing to address"'
{% elif salt['file.search']('/etc/snmp/snmpd.conf', '^[a-z].*(?:v1|v2c|om2sec)') %}
file_V38660-commentV1n2s:
  file.comment:
  - name: '/etc/snmp/snmpd.conf'
  - regex: '^[a-z].*(v1|v2c|om2sec)'
{% endif %}


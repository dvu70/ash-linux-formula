# This Salt test/lockdown implements a SCAP item that has already been
# merged into the DISA-published STIGS
#
# Rule ID:
# - 
#
# Security identifiers:
# - CCE-26993-6
#
# Rule Summary: 
#
# Rule Text:
#
#################################################################

{%- set helperLoc = 'ash-linux/el6/SCAPonly/low/files' %}
{%- set scapId = 'CCE-26993-6' %}
{%- set stigId = 'V-38537' %}

script_{{ scapId }}-describe:
  cmd.run:
    - name: 'printf "
************************************************\n
* NOTE: {{ scapId }} already covered by handler *\n
*       for STIG-ID {{ stigId }}                    *\n
************************************************\n"'

# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38522
# Finding ID:	V-38522
# Version:	RHEL-06-000167
# Finding Level:	Low
#
#     Arbitrary changes to the system time can be used to obfuscate 
#     nefarious activities in log files, as well as to confuse network 
#     services that are highly dependent upon an accurate system time (such 
#     as sshd). All changes to the system time should be audited. 
#
############################################################
 
{% set stig_id = '38522' %}

script_V{{ stig_id }}-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat3/files/V{{ stig_id }}.sh
    - cwd: /root

{% if grains['cpuarch'] == 'x86_64' %}
  {% set pattern = '-a always,exit -F arch=b64 -S settimeofday -k audit_time_rules' %}
  {% set filename = '/etc/audit/audit.rules' %}
  {% if not salt['cmd.run']('grep -c -E -e "' + pattern + '" ' + filename ) == '0' %}
file_V{{ stig_id }}-settimeofday:
  cmd.run:
    - name: 'echo "Appropriate audit-rule already present"'
  {% else %}
file_V{{ stig_id }}-settimeofday:
  file.append:
    - name: '{{ filename }}'
    - text: |
        
        # Audit all system time-modifications via settimeofday (per STIG-ID V-{{ stig_id }})
        {{ pattern }}
  {% endif %}
{% else %}
file_V{{ stig_id }}-settimeofday:
  cmd.run:
    - name: 'echo "Architecture not supported: no changes made"'
{% endif %}

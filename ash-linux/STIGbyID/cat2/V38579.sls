# STIG URL: http://www.stigviewer.com/stig/red_hat_enterprise_linux_6/2014-06-11/finding/V-38579
# Finding ID:	V-38579
# Version:	RHEL-06-000065
# Finding Level:	Medium
#
#     The system boot loader configuration file(s) must be owned by root. 
#     Only root should be able to modify important boot parameters.
#
#  CCI: CCI-000366
#  NIST SP 800-53 :: CM-6 b
#  NIST SP 800-53A :: CM-6.1 (iv)
#  NIST SP 800-53 Revision 4 :: CM-6 b
#
############################################################

{%- set stig_id = '38579' %}

script_V{{ stig_id }}-describe:
  cmd.script:
    - source: salt://ash-linux/STIGbyID/cat2/files/V{{ stig_id }}.sh

{%- if salt['file.file_exists']('/boot/grub/grub.conf') %}

file_V{{ stig_id }}-bootGrubGrub:
  file.managed:
    - name: '/boot/grub/grub.conf'
    - user: root

file_V{{ stig_id }}-etcGrub:
  file.symlink:
    - name: '/etc/grub.conf'
    - target: '/boot/grub/grub.conf'

{%- elif salt['file.file_exists']('/boot/grub.conf') %}

file_V{{ stig_id }}-hardlink:
  module.run:
    - name: 'file.link'
    - src: '/boot/grub.conf'
    - path: '/boot/grub/grub.conf'

file_V{{ stig_id }}-etcGrub:
  file.symlink:
    - name: '/etc/grub.conf'
    - target: '/boot/grub/grub.conf'

{%- endif %}

file_V{{ stig_id }}-hardlink:
  module.run:
    - name: 'file.link'
    - src: '/boot/grub/grub.conf'
    - path: '/boot/grub.conf'
    - unless: 'test -e /boot/grub.conf'

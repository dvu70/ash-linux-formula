# ash-linux-formula
Automated System Hardening for Linux is a [Salt](http://saltstack.org) formula to apply security benchmarks to Linux systems. This specific security bundle primarily targets systems derived from the Red Hat Enterprise Linux 6 distribution (typically RedHat Enterprise Linux, Community ENTerprise OS and Scientific Linux).

This bundle also has partial applicability to upstream distributions of Red Hat Enterprise Linux 6 (i.e., Fedora 12 and 13) as well as custom hybrids that share components with Red Hat Enterprise Linux (such as Amazon Linux and Oracle Unbreakable Linux). The "partial" is a reflection that neither type of distribution attempts to maintain 100% compatibility with the software packages or security settings prescribed by the SCAP and related documentation sets. This package's hardening features are "best effort". Some modules may fail to work 100% correctly and will not cover any distribution-specific components that are not in the main EL6 distribution.

This framework primarily references security guidance is derived from [SCAP guidance for Red Hat Enterprise Linux 6](http://web.nvd.nist.gov/view/ncp/repository/checklist/download?id=1584). SCAP guidances are joint effort between the primary distribution-vendor and the Defense Information Systems Agency (DISA), with contributions from security repositories such as the the National Vulnerability Database's Common Vulnerabilities and Exposure repository (maintained by [MITRE](https://cve.mitre.org/)). These efforts are managed through National Institute of Standards and Technology's [SCAP program](http://scap.nist.gov/). THis program is managed through [NIST's Information Technology Laboratory group](http://www.nist.gov/itl/) .

The SCAP-recommended tests and remediations have been verified to implement the refereneced guidances. This verification has resulted in some deviances from the authoritative guidances. The deviances fall into three primary categories:
* Loosening settings that would result in a system not sustainably manageable in an enterprise-scale system deployment (e.g., automated account-lockouts are timed rather than indefinite: this prevents having to shut down systems to maintenance mode to counteract certain intentional or accidental Denial of Service scenarios)
* Taking a "report-only" response-posture where automated remediation is either not possible (guidance is policy-oriented rather than technical or remediation would require a system rebuild - such as implementing recommended filesystem layouts)
* Hardening beyond what's prescribed by the SCAP guidance - either selecting the more-secure of settings that are prescribed with more than one option or fixing bugs in the formal guidances.

As this Salt-based framework is adopted for wider use, additional security layers will be made availabe. It is expected that these extentions will include security layers to meet the [DISA IAVMs](https://powhatan.iiie.disa.mil/stigs/downloads/zip/FOUO_RedHat_6_V1R8_IAVM.zip) and agency-specific policy-overlays.

##Dependencies

- Optional (one of):
    - git and related RPMs [Already installed if this package was fetched via `git`]
    - wget
    - curl
    - CIFS client
    - NFS client
    - FTP client
- A masterless salt configuration. This is due to the path references to the 
included tools/utilities/content. A later version will look into caching these 
from a salt master.

A masterless salt configuration requires the following software groups and packages:
- EL6 (x86_64) built with "Core" package-group or better
- Additional distribution-vendor RPMs:
    - From the distribution's standard channel/repository
        - audit-libs-python
        - authconfig
        - libcgroup
        - libselinux-python
        - libsemanage-python
        - libyaml
        - m2crypto
        - pciutils
        - policycoreutils-python
        - python-babel
        - python-crypto
        - python-jinja2
        - PyYAML
        - setools-libs
        - setools-libs-python
    - From the distribution's 'Extras' channels/repositories
        - python-backports
        - python-backports-ssl_match_hostname
        - python-chardet
        - python-ordereddict
        - python-requests
        - python-six
        - python-urllib3
- From the [Extra Packages for Enterprise Linux (EPEL)](https://fedoraproject.org/wiki/EPEL) repositories:
    - epel-release
    - openpgm
    - python-msgpack
    - python-zmq
    - salt
    - salt-minion
    - sshpass
    - zeromq3

##Available Run-modes
This collection of modules may be applied as either a "run-all" or "individual-run" invocation.
- Use of the 'runsingly.sh' script will run all of the handlers supplied within this bundle
- Individual modules may be run by manually running them via the 'salt-call' utility
Instructions for both modes are provided later in this document. Each mode runs from the commandline writes to standard-out. Use the `tee` or other utility to capture this to the log-file.

##Configuration
This README assumes that the Salt packages have been downloaded via the `git` commandline-utility's 'clone' operation. This will create an "ash-linux-formula" subdirectory within the directory it is run from. It is assumed that this bundle will also be made available via TAR or 'cpio' archive - each should similarly result in the creation of an "ash-linux-formula" subdirectory somewhere on the host system.

Navigate into the "ash-linux-formula" directory. Within this directory is a setup-utility, `setup.sh`. Running this utility will take care of installing the security policy modules into a file-hierarchy rooted under '/srv/salt'. This is the default search-location for the 'salt-minion' service. The 'salt-minion' service is used to run the security policy modules. This utility will also install an output-filter, `outFilter.sed`, into /usr/local/bin (this filter can be used to suppress some of the less-meaningful output produced by a run of the Salt packages).

The `runsingly.sh` script may be left within and invoked from its default installation directory or moved eslewhere within the host system's filesystem-hierarchy. This script is designed that it should work correctly wherever it's installed or invoked from.

The *ash-linux* formula does not currently support configuration via Salt's "pillar" functionality. Currently-expected deployment profiles did not necessitate the use of pillar to govern application-behavior beyond that available through the "run-all" or "individual-run" invocation methods. As this solution gains greater adoption and specific use-cases are identified, the *ash-linux* formulae will be updated to leverage Salt's "pillar" functionality to match those usage-profiles.

##References
(See links embedded above)
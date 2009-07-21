This contains a local copy of the japitools program written by Stuard Ballard.

The upstream source can be obtained at: http://sab39.netreach.com/Software/Japitools/42/

This local copy is based on the version distributed with ubuntu jaunty: https://launchpad.net/ubuntu/jaunty/+source/japitools

The folder patches contains all local changes against the version included in ubuntu jaunty.

List of changes.
- Treat directory not found as empty directory. Needed when .class files are
  split over more than one directory and not all package directories are
  present in all locations
- Signal via exitcode of japicompat if errors have been found


Usage:

Task: export api of compiled openbravo

run from within a openbravo working copy.

command: ant -f <japitools-dir>/japitools.xml export.api -Djapifile=test -Dopenbravo.base=/home/openbravo/work/ob_branches/pi_pg
parameters:
- japifile: output filename to write the extracted api into
- openbravo.base path to openbravo working copy



Task: list api in readable format

command: <japitools-dir>/japilist -a <japifile>



Task: compare api

command: <japitools-dir>/japicompat -q <reference-file> <new-file>


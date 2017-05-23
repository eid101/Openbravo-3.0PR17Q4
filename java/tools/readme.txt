This contains a local copy of the japitools program written by Stuard Ballard.

The upstream source can be obtained at: http://sab39.netreach.com/Software/Japitools/42/

This local copy is based on the version distributed with ubuntu jaunty: https://launchpad.net/ubuntu/jaunty/+source/japitools

The following repo contains a initial code import of that unmodified codebase + individual
commits on top for every local change done and not pushed upstream.
https://code.openbravo.com/erp/devel/api-checks-japitools-customizations

Current list of changes:
- Treat directory not found as empty directory. Needed when .class files are
  split over more than one directory and not all package directories are
  present in all locations
- Signal via exitcode of japicompat if errors have been found
- Enhance ClassFile.java parser to read newly added entries in Java8
  to not crash when needing to read i.e. java8 java.util.Comparator


Usage:

Task: export api of compiled openbravo

run from within a openbravo working copy.

command: ant -f <japitools-dir>/japitools.xml export.api -Djapifile=test -Dopenbravo.base=/home/openbravo/work/ob_branches/pi_pg
parameters:
- japifile: output filename to write the extracted api into
- openbravo.base path to openbravo working copy
  NOTE: This needs to be a absolute path, a relative path will not work



Task: list api in readable format

command: <japitools-dir>/japilist -a <japifile>



Task: compare api

command: <japitools-dir>/japicompat -q <reference-file> <new-file>


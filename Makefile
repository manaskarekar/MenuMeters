# Copyright (c) 2016-2017 Enrico M. Crisostomo
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
PROGRAM=           MenuMeters
VERSION=           1.9.7.1+emc
DISTDIR=           ./dist
DEPSDIR=           ./deps
BINARIES=          /tmp/MenuMeters.dst
TARGET=            PrefPane
DMGFILE=           $(PROGRAM)-$(VERSION).dmg
PRODUCT=           $(DISTDIR)/$(PROGRAM).pkg
COMPONENT=         $(DEPSDIR)/$(PROGRAM)Component.pkg
COMPONENT_PFILE=   $(PROGRAM).plist
DISTRIBUTION_FILE= distribution.dist
REQUIREMENTS_FILE= requirements.plist

.PHONY : all
all : dmg

.PHONY : dmg
dmg : $(DMGFILE)

$(DISTDIR) $(DEPSDIR) :
	mkdir $@

$(DMGFILE) : $(PRODUCT)
	hdiutil create -volname $(PROGRAM) -srcfolder $(DISTDIR) -ov $(DMGFILE)

$(PRODUCT) : $(REQUIREMENTS_FILE) $(DISTRIBUTION_FILE) $(COMPONENT) | $(DISTDIR)
	productbuild --distribution $(DISTRIBUTION_FILE) --resources . --package-path $(DEPSDIR) $(PRODUCT)

$(BINARIES) : compile

.PHONY : compile
compile :
	xcodebuild -target $(TARGET) install

$(COMPONENT_PFILE) :
	@echo "Error: Missing component pfile."
	@echo "Create a component pfile with make compfiles."
	@exit 1

$(COMPONENT) : $(BINARIES) $(COMPONENT_PFILE) | $(DEPSDIR)
	pkgbuild --root $(BINARIES) --component-plist $(COMPONENT_PFILE) $(COMPONENT)

$(DISTRIBUTION_FILE) :
	@echo "Error: Missing distribution file."
	@echo "Create a distribution file with make distfiles."
	@exit 1

.PHONY : usage
usage :
	@echo "Available targets."
	@echo
	@echo "all        Build the product package."
	@echo "clean      Clean all intermediate files but preserve package and distribution descriptors."
	@echo "compclean  Clean package descriptors."
	@echo "compfiles  Create new package descriptors."
	@echo "distclean  Clean distribution descriptors."
	@echo "distfiles  Create new distribution descriptors."
	@echo "usage      Prints this message."

.PHONY : distfiles
distfiles : $(COMPONENT)
	productbuild --synthesize --product $(REQUIREMENTS_FILE) --package ../EMCLoginItem/EMCLoginItemComponent.pkg --package $(COMPONENT) $(DISTRIBUTION_FILE).new
	@echo "Edit the $(DISTRIBUTION_FILE).new template to create a suitable $(DISTRIBUTION_FILE) file."

.PHONY : compfiles
compfiles : $(BINARIES)
	pkgbuild --analyze --root $(BINARIES) $(COMPONENT_PFILE).new
	@echo "Edit the $(COMPONENT_PFILE).new template to create a suitable $(COMPONENT_PFILE) file."

.PHONY : clean
clean :
	xcodebuild -target $(TARGET) clean
	-rm -f $(DMGFILE) $(PRODUCT) $(COMPONENT)
	-rm -rf $(BINARIES)
	-rm -rf $(DISTDIR) $(DEPSDIR)

.PHONY : distclean
distclean : clean
	-rm -f $(DISTRIBUTION_FILE) $(DISTRIBUTION_FILE).new

.PHONY : compclean
compclean : clean
	-rm -f $(COMPONENT_PFILE) $(COMPONENT_PFILE).new

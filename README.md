MenuMeters
==========

`MenuMeters` is a set of CPU, memory, disk, and network monitoring tools for
macOS.  [Originally][original] created by Alex Harper, development stopped in
2015 and `MenuMeters` stopped working on OS X El Capitan.

A [fork] was created on GitHub and the compatibility issues with OS X were
fixed.  The fork is being actively maintained.

This fork of MenuMeters is known to work in El Capitan, Sierra, High Sierra,
Mojave and Catalina.

I created this fork because I felt the need of streamlining the build and
release process.  I added a `Makefile` which builds `MenuMeters` from scratch,
and creates a DMG archive containing a PKG installer.

Building
--------

`MenuMeters` can be built from sources using the following command:

````
$ make
````

Installing
----------

`MenuMeters` can be installed downloading the DMG archive of the [latest
release][latest] or from the [MenuMeters web page][mm-web].  If you prefer to
build the installer from source, just follow the instructions in
[Build](#build).

[original]: http://www.ragingmenace.com/software/menumeters/
[fork]: https://github.com/yujitach/MenuMeters
[latest]: https://github.com/emcrisostomo/MenuMeters/releases/latest
[mm-web]: https://emcrisostomo.github.io/MenuMeters/

-----

Copyright (c) 2015 Alex Harper

Copyright (c) 2015-2019 Yuji Tachikawa

Copyright (c) 2016-2019 Enrico M. Crisostomo

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

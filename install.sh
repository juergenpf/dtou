#!/bin/bash
prefix=${PREFIX:-/usr/local}

for dir in bin man/man1
do
    if [ ! -d "${prefix}/${dir}" ]; then
	mkdir -p "${prefix}/${dir}"
    fi
    if [ ! -d "${prefix}/${dir}" ]; then
	echo Could not create directory ${prefix}/${dir} >&2
	exit 1
    fi
done

if [ -x dtou ]; then
    cp -pf dtou "${prefix}/bin/"
    chown root.root "${prefix}/bin/dtou"
    chmod 0755 "${prefix}/bin/dtou"
    if [ -f dtou.sed ]; then
	cp -pf dtou.sed "${prefix}/bin/dtou.sed"
	chown root.root "${prefix}/bin/dtou.sed"
	chmod 0644 "${prefix}/bin/dtou.sed"
	pushd "${prefix}/bin" >/dev/null
	for link in utod dos2unix unix2dos
	do	    
	    rm -f ${link} && ln -f dtou $link
	done
	popd >/dev/null
	if [ -f dtou.1 ]; then
	    cp -pf dtou.1 "${prefix}/man/man1"
	    chown root.root "${prefix}/man/man1/dtou.1"
	    chmod 0644 "${prefix}/man/man1/dtou.1"
	fi
    else
	echo Missing dtou.sed >&2
	exit 1
    fi
else
    echo Missing dtou >&2
    exit 1
fi

exit 0

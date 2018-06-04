dnl #########################################################################
dnl ### Init
dnl #########################################################################

dnl -------------------------------------------------------------------------
dnl Test if we are at the good place
dnl
AC_INIT(../../../src/TestManager.cpp)

dnl -------------------------------------------------------------------------
dnl sets build, host, target variables and the same with _alias
dnl
AC_CANONICAL_BUILD

dnl -------------------------------------------------------------------------
dnl Name and version
dnl
AM_INIT_AUTOMAKE(adctest,0)

dnl -------------------------------------------------------------------------
dnl Autotools init
dnl
CFLAGS="$CFLAGS"
CXXFLAGS="$CXXFLAGS"
AC_PROG_CC
AC_PROG_CXX
AC_PROG_INSTALL

dnl #########################################################################
dnl ### Options
dnl #########################################################################

dnl -------------------------------------------------------------------------
dnl Arguments - Enable
dnl
AC_ARG_ENABLE(debug,        AC_HELP_STRING([--enable-debug],        [Enable full debug]),                       , enable_debug=no)
AC_ARG_ENABLE(gprof,        AC_HELP_STRING([--enable-gprof],        [Enable gprof log]),                        , enable_gprof=no)
AC_ARG_ENABLE(universal_binary, AC_HELP_STRING([--enable-universal_binary], [Create Mac PPC/i386 Universal binary]),      , enable_universal_binary=no)
AC_ARG_ENABLE(arch-ppc,         AC_HELP_STRING([--with-arch-ppc],           [Create Mac PPC Universal binary]),           , enable_arch_ppc=no)
AC_ARG_ENABLE(arch-i386,        AC_HELP_STRING([--with-arch-i386],          [Create Mac i386 Universal binary]),          , enable_arch_i386=no)
AC_ARG_ENABLE(arch-x86_64,      AC_HELP_STRING([--enable-arch-x86_64],      [Create Mac x86_64 architecture]),            , enable_arch_x86_64=no)

dnl -------------------------------------------------------------------------
dnl Arguments - With
dnl
AC_ARG_WITH(macosx-sdk,         AC_HELP_STRING([--with-macosx-sdk],         [Force the Mac SDK]),                         , with_macosx_sdk=no)
AC_ARG_WITH(macosx-version-min, AC_HELP_STRING([--with-macosx-version-min], [Force the Mac Version]),                     , with_macosx_version_min=no)

dnl #########################################################################
dnl ### Specific flags
dnl #########################################################################

dnl -------------------------------------------------------------------------
dnl WxWidgets
dnl

if test -e ../../../../wxWidgets/wx-config ; then
	CFLAGS="$CFLAGS $(../../../../wxWidgets/wx-config --cflags)"
	CXXFLAGS="$CXXFLAGS $(../../../../wxWidgets/wx-config --cxxflags)"
	LIBS="$LIBS $(../../../../wxWidgets/wx-config --libs)"
else
	CFLAGS="$CFLAGS $(wx-config --cflags)"
	CXXFLAGS="$CXXFLAGS $(wx-config --cxxflags)"
	LIBS="$LIBS $(wx-config --libs)"
fi

dnl -------------------------------------------------------------------------
dnl portaudio
dnl
if test -e ../../../../portaudio/lib/.libs/libportaudio.a ; then
	CXXFLAGS="$CXXFLAGS -I../../../../portaudio/include"
	LIBS="$LIBS ../../../../portaudio/lib/.libs/libportaudio.a -framework CoreAudio -framework AudioToolbox -framework AudioUnit -framework Carbon"
else
	CXXFLAGS="$CXXFLAGS $(pkg-config --cflags portaudio-2.0)"
	LIBS="$LIBS $(pkg-config --libs portaudio-2.0)"
fi

dnl -------------------------------------------------------------------------
dnl sndfile
dnl
if test -e ../../../../libsndfile/src/.libs/libsndfile.a ; then
	CXXFLAGS="$CXXFLAGS -I../../../../libsndfile/src"
	LIBS="$LIBS ../../../../libsndfile/src/.libs/libsndfile.a"
else
	CXXFLAGS="$CXXFLAGS $(pkg-config --cflags sndfile)"
	LIBS="$LIBS $(pkg-config --libs sndfile)"
fi

dnl #########################################################################
dnl ### C/C++ compiler options used to compile
dnl #########################################################################

dnl -------------------------------------------------------------------------
dnl GNU compiler
dnl
if test "$GXX" = yes ; then
	if test "$enable_debug" = "yes"; then
		CFLAGS="$CFLAGS -O0 -g -Wall -Wundef"
		CXXFLAGS="$CXXFLAGS -O0 -g -Wall -W -Wundef -Wcast-qual -Wno-ctor-dtor-privacy"
	else
		CFLAGS="$CFLAGS -O2"
		CXXFLAGS="$CXXFLAGS -O2"
	fi
	if test "$enable_gprof" = "yes"; then
		CFLAGS="$CFLAGS -pg -g"
		CXXFLAGS="$CXXFLAGS -pg -g"
	fi
fi

dnl #########################################################################
dnl ### Compiler specific
dnl #########################################################################

dnl -------------------------------------------------------------------------
case "${build}" in
  powerpc-montavista* )
    CFLAGS="$CFLAGS -D__MONTAVISTA__"
    CXXFLAGS="$CXXFLAGS -D__MONTAVISTA__"
  ;;
esac

dnl -------------------------------------------------------------------------
dnl Mac Architecture and SDK
dnl
if test "$enable_universal_binary" = "yes"; then
	enable_arch_ppc=yes
	enable_arch_i386=yes
	if test "$with_macosx_sdk" = no ; then
		with_macosx_sdk="/Developer/SDKs/MacOSX10.5.sdk"
	fi
	if test "$with_macosx_version_min" = no ; then
		with_macosx_version_min="10.5"
	fi
fi
if test "$enable_arch_ppc" = "yes"; then
	CXXFLAGS="$CXXFLAGS -arch ppc"
	CFLAGS="$CFLAGS -arch ppc"
	LDFLAGS="$LDFLAGS -arch ppc"
fi
if test "$enable_arch_i386" = "yes"; then
	CXXFLAGS="$CXXFLAGS -arch i386"
	CFLAGS="$CFLAGS -arch i386"
	LDFLAGS="$LDFLAGS -arch i386"
fi
if test "$enable_arch_x86_64" = "yes"; then
	CXXFLAGS="$CXXFLAGS -arch x86_64"
	CFLAGS="$CFLAGS -arch x86_64"
	LDFLAGS="$LDFLAGS -arch x86_64"
fi
if test "$with_macosx_sdk" = "yes" ; then
	CXXFLAGS="-isysroot /Developer/SDKs/MacOSX10.5.sdk $CXXFLAGS"
	CFLAGS="-isysroot /Developer/SDKs/MacOSX10.5.sdk $CFLAGS"
	LDFLAGS="-isysroot /Developer/SDKs/MacOSX10.5.sdk $LDFLAGS"
elif test "x$with_macosx_sdk" != xno ; then
	CXXFLAGS="-isysroot $with_macosx_sdk $CXXFLAGS"
	CFLAGS="-isysroot $with_macosx_sdk $CFLAGS"
	LDFLAGS="-isysroot $with_macosx_sdk $LDFLAGS"
fi
if test "x$with_macosx_version_min" != xno ; then
	CXXFLAGS="-mmacosx-version-min=$with_macosx_version_min $CXXFLAGS"
	CFLAGS="-mmacosx-version-min=$with_macosx_version_min $CFLAGS"
	LDFLAGS="-mmacosx-version-min=$with_macosx_version_min $LDFLAGS"
fi

dnl #########################################################################
dnl ### Output
dnl #########################################################################

AC_OUTPUT(Makefile)

dnl #########################################################################
dnl ### Report how we have been configured
dnl #########################################################################

echo ""
echo "Configured ADCTest for '$build'"
echo ""
echo "  CXXFLAGS: $CXXFLAGS"
echo "  LIBS: $LIBS"

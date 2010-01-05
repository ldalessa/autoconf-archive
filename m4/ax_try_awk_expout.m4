# ===========================================================================
#        http://www.nongnu.org/autoconf-archive/ax_try_awk_expout.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_TRY_AWK_EXPOUT(NAME,TEST-INPUT,TEST-BODY,EXPECTED-OUTPUT,[ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Run a test using the awk program found on AWK variable. The test being
#   run has TEST-BODY as body and is feeded with TEST-INPUT. Check if the
#   test gives the expected output. If successful execute ACTION-IF-SUCCESS
#   otherwise ACTION-IF-FAILURE.
#
#   This work is heavily based upon testawk.sh script by Heiner Steven. You
#   should find his script (and related works) at
#   <http://www.shelldorado.com/articles/awkcompat.html>. Thanks to
#   Alessandro Massignan for his suggestions and extensive nawk tests on
#   FreeBSD.
#
# LICENSE
#
#   Copyright (c) 2009 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

AC_DEFUN([AX_TRY_AWK_EXPOUT], [
  AC_REQUIRE([AX_NEED_AWK])

  AC_MSG_CHECKING([if $AWK supports $1])

  cat <<EOF > conftest.out
$2
EOF

  ax_try_awk_output=`$AWK '{ [$3] ; }' conftest.out 2> /dev/null`
  ax_try_awk_result=$?

  rm -f conftest.out

  AS_IF([test $ax_try_awk_result -eq 0],[
    AS_IF([test "X$ax_try_awk_output" = "X[$4]"],[
        AC_MSG_RESULT([yes])
        $5
    ],[
        AC_MSG_RESULT([no])
        $6
    ])
  ],[
    AC_MSG_RESULT([no])
    $6
  ])
])

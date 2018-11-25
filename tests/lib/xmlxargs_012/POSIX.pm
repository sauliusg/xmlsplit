
# A fake POSIX module to inject special ARG_MAX value for testing.

package POSIX;

our @ISA = qw( Exporter );
our @EXPORT_OK = qw(
    sysconf
);

use strict;
use warnings;

sub _SC_ARG_MAX
{
    return 0;
}

sub sysconf
{
    return 91;
}
    
1;

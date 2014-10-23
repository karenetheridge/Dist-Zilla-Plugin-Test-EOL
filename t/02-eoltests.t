use strict;
use warnings FATAL => 'all';

# this is just like t/01-basic.t except we use [EOLTests].

use Path::Tiny;
my $code = path('t', '01-basic.t')->slurp_utf8;

$code =~ s/use if \$ENV\{AUTHOR_TESTING\}, 'Test::Warnings';//;
$code =~ s/Test::EOL(?!'\s*=>)/EOLTests/g;
$code =~ s{xt(.)author(.)eol\.t}{xt$1release$2eol.t}g;

eval $code;
die $@ if $@;

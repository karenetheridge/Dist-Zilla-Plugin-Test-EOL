use strict;
use warnings;
package Dist::Zilla::Plugin::EOLTests;
# ABSTRACT: (DEPRECATED) Release tests making sure correct line endings are used

our $VERSION = '0.19';

use Moose;
extends 'Dist::Zilla::Plugin::Test::EOL';
use namespace::autoclean;

before register_component => sub {
    warnings::warnif('deprecated',
        "!!! [EOLTests] is deprecated and may be removed in a future release; replace it with [Test::EOL] (note the different default filename)\n",
    );
};

has '+filename' => (
    default => sub { return 'xt/release/eol.t' },
);

__PACKAGE__->meta->make_immutable;
1;
__END__

=pod

=head1 SYNOPSIS

In your F<dist.ini>:

    [EOLTests]

=head1 DESCRIPTION

This is a plugin that runs at the L<gather files|Dist::Zilla::Role::FileGatherer> stage,
providing the file F<xt/release/eol.t>, a standard L<Test::EOL> test.

THIS MODULE IS DEPRECATED. Please use
L<Dist::Zilla::Plugin::Test::EOL> instead. it may be removed at a
later time (but not before April 2015).

In the meantime, it will continue working -- although with a warning.
Refer to the replacement for the full documentation.

=cut

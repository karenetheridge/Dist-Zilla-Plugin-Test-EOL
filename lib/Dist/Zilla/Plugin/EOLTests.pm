use strict;
use warnings;
package Dist::Zilla::Plugin::EOLTests;
# ABSTRACT: Release tests making sure correct line endings are used

use Moose;
extends 'Dist::Zilla::Plugin::Test::EOL';
use namespace::autoclean;

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

=cut

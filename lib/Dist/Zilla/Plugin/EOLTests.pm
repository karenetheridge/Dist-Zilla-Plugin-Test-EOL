package Dist::Zilla::Plugin::EOLTests;
# ABSTRACT: Release tests making sure correct line endings are used

use Moose;
use namespace::autoclean;

# VERSION

extends 'Dist::Zilla::Plugin::Test::EOL';

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing
the following files:

=for :list
* xt/release/eol.t
a standard Test::EOL test

=attr trailing_whitespace

If this option is set to a true value,
C<< { trailing_whitespace => 1 } >> will be passed to
L<Test::EOL/all_perl_files_ok>. It defaults to C<1>.

=cut

has '+filename' => (
    default => sub { return 'xt/release/eol.t' },
);

__PACKAGE__->meta->make_immutable;

1;

use strict;
use warnings;
package Dist::Zilla::Plugin::Test::EOL;
# ABSTRACT: Author tests making sure correct line endings are used
# KEYWORDS: plugin test testing author development whitespace newline linefeed formatting

use Moose;
use Sub::Exporter::ForMethods 'method_installer';
use Data::Section 0.004 # fixed header_re
    { installer => method_installer }, '-setup';
use namespace::autoclean;

with
    'Dist::Zilla::Role::FileGatherer',
    'Dist::Zilla::Role::TextTemplate',
    'Dist::Zilla::Role::PrereqSource',
;

has trailing_whitespace => (
    is      => 'ro',
    isa     => 'Bool',
    default => 1,
);

has filename => (
    is => 'ro', isa => 'Str',
    lazy => 1,
    default => sub { return 'xt/author/eol.t' },
);

around dump_config => sub
{
    my ($orig, $self) = @_;
    my $config = $self->$orig;

    $config->{+__PACKAGE__} = {
         filename => $self->filename,
    };
    return $config;
};

sub gather_files
{
    my $self = shift;

    require Dist::Zilla::File::InMemory;

    $self->add_file(
        Dist::Zilla::File::InMemory->new(
            name => $self->filename,
            content => $self->fill_in_string(
                ${$self->section_data('__TEST__')},
                {
                    plugin => \$self,
                    trailing_ws => \$self->trailing_whitespace
                },
            ),
        )
    );
    return;
}

sub register_prereqs
{
    my $self = shift;
    $self->zilla->register_prereqs(
        {
            type  => 'requires',
            phase => 'develop',
        },
        'Test::More' => 0,
        'Test::EOL' => 0,
    );
}

__PACKAGE__->meta->make_immutable;
1;

=pod

=head1 DESCRIPTION

Generate an author L<Test::EOL>.

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing
the file F<xt/author/eol.t>, a standard L<Test::EOL> test.

=head1 CONFIGURATION OPTIONS

This plugin accepts the following options:

=head2 C<trailing_whitespace>

If this option is set to a true value,
C<< { trailing_whitespace => 1 } >> will be passed to
L<Test::EOL/all_perl_files_ok>. It defaults to C<1>.

What this option is going to do is test for the lack of trailing whitespace at
the end of the lines (also known as "trailing space").

=head2 C<filename>

The filename of the test to add - defaults to F<xt/author/test-eol.t>.

=for Pod::Coverage gather_files register_prereqs

=head1 ACKNOWLEDGMENTS

This module is a fork of L<Dist::Zilla::Plugin::EOLTests> and was originally
written by Florian Ragwitz. It was forked because the Test:: namespace
is preferred for test modules, and because I would prefer to have EOL tests
be Author tests.

=head1 SEE ALSO

=for :list
* Test::EOL

=cut

__DATA__
___[ __TEST__ ]___
use strict;
use warnings;

# this test was generated with {{ ref($plugin) . ' ' . ($plugin->VERSION || '<self>') }}

use Test::More;
use Test::EOL;

all_perl_files_ok({ trailing_whitespace => {{ $trailing_ws }} });

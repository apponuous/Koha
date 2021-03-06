#!/usr/bin/perl

# Copyright 2012 BibLibre
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# Koha; if not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA  02111-1307 USA


=head1 members/statistics.pl
  Generate statistic issues for a member
=cut

use Modern::Perl;

use CGI;
use C4::Auth;
use C4::Branch;
use C4::Context;
use C4::Members;
use C4::Members::Statistics;
use C4::Output;

my $input = new CGI;

my ( $template, $loggedinuser, $cookie ) = get_template_and_user(
    {   template_name   => "members/statistics.tmpl",
        query           => $input,
        type            => "intranet",
        authnotrequired => 0,
        flagsrequired   => { borrowers => 1 },
        debug           => 1,
    }
);

my $borrowernumber = $input->param('borrowernumber');

# Set informations for the patron
my $borrower = GetMemberDetails( $borrowernumber, 0 );
if ( not defined $borrower ) {
    $template->param (unknowuser => 1);
    output_html_with_http_headers $input, $cookie, $template->output;
    exit;
}

foreach my $key ( keys %$borrower ) {
    $template->param( $key => $borrower->{$key} );
}

# Construct column names
my $fields = C4::Context->preference('StatisticsFields') || 'location|itype|ccode';
our @statistic_column_names = split '\|', $fields;
our @value_column_names = ( 'count_precedent_state', 'count_total_issues_today', 'count_total_issues_returned_today' );
our @column_names = ( @statistic_column_names, @value_column_names );

# Get statistics
my $precedent_state = GetPrecedentStateByBorrower( $borrowernumber );
my $total_issues_today = GetTotalIssuesTodayByBorrower( $borrowernumber );
my $total_issues_returned_today = GetTotalIssuesReturnedTodayByBorrower( $borrowernumber );
my $r = merge (
    @$precedent_state, @$total_issues_today, @$total_issues_returned_today
);
add_actual_state( $r );
my ( $total, $datas ) = build_array( $r );

# Gettings sums
my $count_total_precedent_state = $total->{count_precedent_state} || 0;
my $count_total_issues = $total->{count_total_issues_today} || 0;
my $count_total_issues_returned = $total->{count_total_issues_returned_today} || 0;
my $count_total_actual_state = ($count_total_precedent_state - $count_total_issues_returned + $count_total_issues);

$template->param(
    statisticsview => 1,
    datas          => $datas,
    column_names   => \@statistic_column_names,
    length_keys    => scalar( @statistic_column_names),
    count_total_issues => $count_total_issues,
    count_total_issues_returned => $count_total_issues_returned,
    count_total_precedent_state => $count_total_precedent_state,
    count_total_actual_state => $count_total_actual_state,
);

output_html_with_http_headers $input, $cookie, $template->output;


=head1 FUNCTIONS

=head2 add_actual_state
  Add a 'count_actual_state' key in all hashes
  count_actual_state = count_precedent_state - count_total_issues_returned_today + count_total_issues_today
=cut
sub add_actual_state {
    my ( $array ) = @_;
    for my $hash ( @$array ) {
        $hash->{count_actual_state} = ( $hash->{count_precedent_state} // 0 ) - ( $hash->{count_total_issues_returned_today} // 0 ) + ( $hash->{count_total_issues_today} // 0 );
    }
}

=head2 build_array
  Build a new array containing values of hashes.
  It used by template whitch display silly values.
  ex:
    $array = [
      {
        'count_total_issues_returned_today' => 1,
        'ccode' => 'ccode',
        'count_actual_state' => 1,
        'count_precedent_state' => 1,
        'homebranch' => 'homebranch',
        'count_total_issues_today' => 1,
        'itype' => 'itype'
      }
    ];
  and returns:
    [
      [
        'homebranch',
        'itype',
        'ccode',
        1,
        1,
        1,
        1
      ]
    ];

=cut
sub build_array {
    my ( $array ) = @_;
    my ( @r, $total );
    for my $hash ( @$array) {
        my @line;
        for my $cn ( ( @column_names, 'count_actual_state') ) {
            if ( grep /$cn/, ( @value_column_names, 'count_actual_state') ) {
                $hash->{$cn} //= 0;
                if ( exists $total->{$cn} ) {
                    $total->{$cn} += $hash->{$cn} if $hash->{$cn};
                } else {
                    $total->{$cn} = $hash->{$cn};
                }
            }
            push @line, $hash->{$cn};
        }
        push @r, \@line;
    }
    return ( $total, \@r );
}

=head2 merge
  Merge hashes with the same statistic column names into one
  param: array, a arrayref of arrayrefs
  ex:
  @array = (
     {
       'ccode' => 'ccode',
       'count_precedent_state' => '1',
       'homebranch' => 'homebranch',
       'itype' => 'itype'
     },
     {
       'count_total_issues_returned_today' => '1',
       'ccode' => 'ccode',
       'homebranch' => 'homebranch',
       'itype' => 'itype'
     }
   );
   and returns:
   [
     {
       'count_total_issues_returned_today' => '1',
       'ccode' => 'ccode',
       'count_precedent_state' => '1',
       'homebranch' => 'homebranch',
       'itype' => 'itype'
     }
   ];

=cut
sub merge {
    my @array = @_;
    my @r;
    for my $h ( @array ) {
        my $exists = 0;
        for my $ch ( @r ) {
            $exists = 1;
            for my $cn ( @statistic_column_names ) {
                if ( not $ch->{$cn} eq $h->{$cn} ) {
                    $exists = 0;
                    last;
                }
            }
            if ($exists){
                for my $cn ( @value_column_names ) {
                    next if not exists $h->{$cn};
                    $ch->{$cn} = $h->{$cn} ? $h->{$cn} : 0;
                }
                last;
            }
        }

        if ( not $exists ) {push @r, $h;}
    }
    return \@r;
}

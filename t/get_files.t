#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Warnings;
use lib qw{t/lib};
use DirBuilder qw{build_tree};;

my $module = 'App::diffdir';
use_ok( $module );

get_files();

done_testing();

sub get_files {
    my $dd = App::diffdir->new;

    my $path = {
        '.git' => {
        },
        file1 => 1,
        file2 => 2,
        dir1  => {
            dfile1 => 3,
        }
    };
    build_tree( 't/find_files/a', $path );

    $path->{file2} = 3;
    $path->{file3} = 4;
    build_tree( 't/find_files/b', $path );
    my %found = $dd->get_files('t/find_files/a', 't/find_files/b');
    diag explain \%found;
}

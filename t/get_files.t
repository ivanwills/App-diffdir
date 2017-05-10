#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Warnings;
use Path::Tiny;
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
            dfile2 => 3,
        }
    };

    # build first tree
    build_tree( 't/get_files/a', $path );

    # alter for second tree
    $path->{file2} = 3;
    $path->{file3} = 4;
    delete $path->{dir1}{dfile2};

    # build second tree
    build_tree( 't/get_files/b', $path );
    my %found = $dd->get_files('t/get_files/a', 't/get_files/b');

    diag explain \%found;
    is scalar keys %found, 6, 'All files from both trees found';
    ok $found{'dir1/dfile2'}, 'Found file only in first location';
    ok $found{file3}, 'Found file only in second location';

    path('t/get_files')->remove_tree;
}

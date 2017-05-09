#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Test::Warnings;
use lib qw{t/lib};
use DirBuilder qw{build_tree};;

my $module = 'App::diffdir';
use_ok( $module );

find_files();

done_testing();

sub find_files {
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
    my @a = $dd->find_files('t/find_files/a');
    is scalar @a, 4, 'Find all 4 files';
}

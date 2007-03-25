#!perl
# Copyright (c) 2007 Jonathan Rockway <jrockway@cpan.org>

use strict;
use warnings;
use Test::More tests => 4;
use File::Attributes::Extended;
use Directory::Scratch;

my $tmp = Directory::Scratch->new;
$tmp->touch('foo');
my $file = $tmp->exists('foo');
ok(-e $file, 'file exists');

my $fax = File::Attributes::Extended->new;
$fax->set($file, 'foo', 'yes');
$fax->set($file, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', 'set');

is($fax->get($file, 'foo'), 'yes', 'foo set');
is($fax->get($file, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'), 'set', 'XXXX... set');

my @set   = sort qw(foo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX);
my @attrs = $fax->list('foo');
is_deeply(\@set, \@attrs, 'list attributes that we just set');

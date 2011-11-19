#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Foo';

is( get('/success'), 'base, success', 'Successful chain works');
is( get('/fail'), 'base', 'Die in base correctly stops chain');
is( get('/middle_fail'), 'base', 'Die in middle of chain works');

done_testing();

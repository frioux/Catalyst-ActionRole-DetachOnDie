#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use lib 't/lib';

use Catalyst::Test 'Foo';

is( get('/success'), 'base, success', 'Successful chain works');
is( get('/fail'), 'base', 'Die in base correctly stops chain');
is( get('/middle_fail'), 'base', 'Die in middle of chain works');

is( get('/base/success'), 'base_base, success', 'Base Successful chain works');
is( get('/base/fail'), 'base_base', 'Base Die in base correctly stops chain');
is( get('/base/middle_fail'), 'base_base', 'Base Die in middle of chain works');

is( get('/fail_ctx_error'), '1, base', 'ctx error preserved when die in Chain worked.');

done_testing();

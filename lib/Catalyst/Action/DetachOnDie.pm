package Catalyst::Action::DetachOnDie;

use Moose;

extends 'Catalyst::Action';
with 'Catalyst::ActionRole::DetachOnDie';

no Moose;

1;

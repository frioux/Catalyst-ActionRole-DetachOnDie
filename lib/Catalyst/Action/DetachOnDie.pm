package Catalyst::Action::DetachOnDie;

use Moose;

# ABSTRACT: If something dies in a chain, stop the chain

extends 'Catalyst::Action';
with 'Catalyst::ActionRole::DetachOnDie';

no Moose;

1;

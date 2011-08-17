package Catalyst::Action::Test;
use Moose;
use Try::Tiny;
extends 'Catalyst::Action';

around execute => sub {
    my ($orig, $self) = (shift, shift);
    my ($controller, $c, @args) = @_;
    my $ret; my $error;
    try { $ret = $self->$orig($controller, $c, @args) }
    catch { $c->log->warn("Caught $_ detaching"); $error = 1; $c->error([ @{ $c->error }, $_ ]); };
    $c->detach if $error;
    $ret;
};

1;


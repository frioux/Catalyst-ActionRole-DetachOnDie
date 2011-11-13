package Catalyst::Action::Test;
use Moose;
use Try::Tiny;
extends 'Catalyst::Action';

around execute => sub {
   my ($orig, $self, $controller, $c, @args) = @_;

   try {
      $self->$orig($controller, $c, @args)
   } catch {
      $c->log->error("Caught exception: $_ detaching");
      $c->detach;
      $c->error([ @{ $c->error }, $_ ]);
      undef
   }
};

1;


package Catalyst::ActionRole::DetachOnDie;
use Moose::Role;
use Try::Tiny;

# ABSTRACT: If something dies in a chain, stop the chain

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

no Moose::Role;

1;


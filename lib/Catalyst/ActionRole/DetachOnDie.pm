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

=pod

=head1 SYNOPSIS

 package MyApp::Controller::Foo;
 use Moose;

 BEGIN { extends 'Catalyst::Controller::ActionRole' }

 __PACKAGE__->config(
    action => {
       '*' => { Does => 'DetachOnDie' },
    },
 );

 ...;

=head1 DESCRIPTION

Chained dispatch is arguably one of the coolest features Catalyst has to offer,
unfortunately it is marred by the bizarre decision to have exceptions thrown
B<not> detach a chain.  To be clear, if one has a chain as follows:

 sub first  : Chained('/') PathPart('') CaptureArgs(0) { ... }
 sub middle : Chained('first') PathPart('middle') CaptureArgs(0) { ... }
 sub last   : Chained('middle') PathPart('') Args(0) { ... }

If the URL /middle is dispatched to, but an exception is raised in the
C<middle> (or even C<first>) method, the C<last> method will B<still> run!
This module solves that problem.  I recommend you use it as I have documented
in the L</SYNOPSIS>, as that will make it apply to all of your actions, but if
for some reason you do not want to apply it to all actions you can apply it per
action as follows:

 sub foo : Chained('bar') PathPart('') CaptureArgs(0) Does('DetachOnDie') { ... }

If you do not want to use the action role, check out
L<Catalyst::Action::DetachOnDie>, which does the same thing but does not
require the use of L<Catalyst::Controller::ActionRole>.

package Set::Similarity::CosinePDL;

use strict;
use warnings;

use namespace::autoclean;

use PDL;

use parent 'Set::Similarity';

our $VERSION = '0.005';

sub from_sets {
  my ($self, $set1, $set2) = @_;
  $self->make_elem_list($set1,$set2);

  return $self->cosine( 
	norm($self->make_vector( $set1 )), 
	norm($self->make_vector( $set2 )) 
  );	
}

sub make_vector {
  my ( $self, $tokens ) = @_;
  my %elements = $self->get_elements( $tokens );
  my $vector = zeroes $self->{'elem_count'};
	
  for my $key ( keys %elements ) {
	my $value = $elements{$key};
	my $offset = $self->{'elem_index'}->{$key};
	index( $vector, $offset ) .= $value;
  }
  return $vector;
}

sub get_elements {			
  my ( $self, $tokens ) = @_;
  my %elements;  
  do { $_++ } for @elements{@$tokens};
  return %elements;
}	

sub make_elem_list {
  my ( $self,$tokens1,$tokens2 ) = @_;
  my %all_elems;
  for my $tokens ( $tokens1,$tokens2 ) {
	my %elements = $self->get_elements( $tokens );
	for my $key ( keys %elements ) {
	  $all_elems{$key} += $elements{$key};
	}
  }
	
  # create a lookup hash
  my %lookup;
  my @sorted_elems = sort keys %all_elems;
  @lookup{@sorted_elems} = (0..scalar(@sorted_elems)-1 );
	
  $self->{'elem_index'} = \%lookup;
  $self->{'elem_list'} = \@sorted_elems;
  $self->{'elem_count'} = scalar @sorted_elems;
}

# Assumes both incoming vectors are normalized
sub cosine {
  my ( $self, $vec1, $vec2 ) = @_;
  my $cos = inner( $vec1, $vec2 );	# inner product
  return $cos->sclr();  # converts PDL object to Perl scalar
}

1;


__END__

=head1 NAME

Set::Similarity::Cosine - Cosine similarity for sets

=head1 SYNOPSIS

 use Set::Similarity::CosinePDL;
 
 # object method
 my $cosine = Set::Similarity::CosinePDL->new;
 my $similarity = $cosine->similarity('Photographer','Fotograf');
 

=head1 DESCRIPTION

=head2 Cosine similarity

A intersection B / (sqrt(A) * sqrt(B))


=head1 METHODS

L<Set::Similarity::CosinePDL> inherits all methods from L<Set::Similarity> and implements the
following new ones.

=head2 from_sets

  my $similarity = $object->from_sets(['a'],['b']);
 
This method expects two arrayrefs of strings as parameters. The parameters are not checked, thus can lead to funny results or uncatched divisions by zero.
 
If you want to use this method directly, you should take care that the elements are unique. Also you should catch the situation where one of the arrayrefs is empty (similarity is 0), or both are empty (similarity is 1).

=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity-CosinePDL>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013-2014 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


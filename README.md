# NAME

Set::Similarity::Cosine - Cosine similarity for sets

# SYNOPSIS

    use Set::Similarity::CosinePDL;
    
    # object method
    my $cosine = Set::Similarity::CosinePDL->new;
    my $similarity = $cosine->similarity('Photographer','Fotograf');
    
    # class method
    my $cosine = 'Set::Similarity::CosinePDL';
    my $similarity = $cosine->similarity('Photographer','Fotograf');
    
    # from 2-grams
    my $width = 2;
    my $similarity = $cosine->similarity('Photographer','Fotograf',$width);
    
    # from arrayref of tokens
    my $similarity = $cosine->similarity(['a','b'],['b']);
    
    # from hashref of features
    my $bird = {
      wings    => true,
      eyes     => true,
      feathers => true,
      hairs    => false,
      legs     => true,
      arms     => false,
    };
    my $mammal = {
      wings    => false,
      eyes     => true,
      feathers => false,
      hairs    => true,
      legs     => true,
      arms     => true, 
    };
    my $similarity = $cosine->similarity($bird,$mammal);
    
    # from arrayref sets
    my $bird = [qw(
      wings
      eyes
      feathers
      legs
    )];
    my $mammal = [qw(
      eyes
      hairs
      legs
      arms
    )];
    my $similarity = $cosine->from_sets($bird,$mammal);

# DESCRIPTION

## Cosine similarity

A intersection B / (sqrt(A) \* sqrt(B))

# METHODS

[Set::Similarity::CosinePDL](https://metacpan.org/pod/Set::Similarity::CosinePDL) inherits all methods from [Set::Similarity](https://metacpan.org/pod/Set::Similarity) and implements the
following new ones.

## from\_sets

     my $similarity = $object->from_sets(['a'],['b']);
    

This method expects two arrayrefs of strings as parameters. The parameters are not checked, thus can lead to funny results or uncatched divisions by zero.

If you want to use this method directly, you should take care that the elements are unique. Also you should catch the situation where one of the arrayrefs is empty (similarity is 0), or both are empty (similarity is 1).

# SOURCE REPOSITORY

[http://github.com/wollmers/Set-Similarity-CosinePDL](http://github.com/wollmers/Set-Similarity-CosinePDL)

# AUTHOR

Helmut Wollmersdorfer, <helmut.wollmersdorfer@gmail.com>

# COPYRIGHT AND LICENSE

Copyright (C) 2013-2014 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

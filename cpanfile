requires 'perl', '5.008005';

requires 'PDL', '0';
requires 'Set::Similarity', '0.009';
requires 'namespace::autoclean', '0';

on test => sub {
    requires 'Test::More', '0.88';
};

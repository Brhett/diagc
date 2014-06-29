#!/usr/bin/perl
use strict;
use warnings;

# temp.txt will have the device xml response from server.
my $filename = 'temp.txt';
open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
print "done opening file\n";
my $temp_content;
while (<$fh>) {
    my $chunked = $_;
	$chunked =~ s/^([0-9]+)\r\n//;
	print $chunked;
	$temp_content .= $chunked;
}

print "\n\n\n NEW CONTENT : $temp_content\n";
close $fh;

1;

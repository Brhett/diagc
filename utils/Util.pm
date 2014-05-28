#!/usr/bin/perl
package Util;
use strict;

sub print_diagc_start {
    print "\n\nDIAGC - Utility Client\n";
    print " ---------------------\n";
    print "1. GetDeviceStatus \n";
    print "2. CancelTest \n";
    print "3. GetActiveTestIDs \n";
    print "4. NSLookup \n";
    print "5. Ping \n";
    print "6. Traceroute \n";
    print "7. GetTestIDs\n";
    print "8. GetTestInfo\n";
    print "9. GetNSLookupResult \n";
    print "10. GetPingResult \n";
    print "11. GetTracerouteResult \n";
    print "x - Exit application \n";
    print " ---------------------\n";
}

sub get_user_input {
    print "Input the number corresponding to the action to be invoked : ";
    our $USR_OPT = <>;
    chomp $USR_OPT;
    if ($USR_OPT eq 'x') {
	    return ($USR_OPT);
	}
    print "Enter the DIAGE host IPAddress : " ;
    our $IP = <>;
    chomp $IP;
    print "Enter the DIAGE host Port Number : ";
    our $PORT = <>;
    chomp $PORT;
    return ($USR_OPT, $IP, $PORT);
}

1;

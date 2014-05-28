# Copyright (c) 2014, CableLabs, Inc.
# All rights reserved.
#
# Author: Parthiban Balasubramanian<p.balasubramanian@cablelabs.com>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

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

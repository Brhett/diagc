#!/usr/bin/perl

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

package ResponseValidator;

sub valiate_soap_response {
    my $soap_response = $_[0];

    if($soap_response->is_success) {
        print "************Success*************\n";
        print_message ($soap_response);
    } else {
        print "************Error*************\n";
        print_message ($soap_response);
    }
    print "\n************End of Action*************\n";
    return $soap_response->content;
}

sub print_message {
        print "Response status : \n";
        print "-----------------\n";
        print $_[0]->status_line . "\n";
        print "\n";
        print "Response Body: \n";
        print "--------------\n";
        print $_[0]->content . "\n";
}

sub get_test_id_from_response {
    my $reponse_string = $_[0];
    #print "GOT RESPONSE: $reponse_string \n";
    my $test_id = substr $reponse_string, index($reponse_string,"<TestID>") + length("<TestID>"), index($reponse_string,"</TestID>");
    my @test_id = $reponse_string =~ m/<TestID>(.*)<\/TestID>/g;
    return "@test_id";
}

1;

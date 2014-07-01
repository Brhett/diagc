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

package SocketCalls;

use utils::SoapHeaders qw( );
use LWP::UserAgent;
use HTTP::Request;

sub invoke_soap_request {
    #print "The passed IP Address :" . $_[0] . "\n";
    #print "The passed port no :" . $_[1] . "\n";
    #print "Request Message : " . $_[2] . "\n";
    #print "Soap Action :".$_[3] . "\n";
    my $post_url;
    #Use absolute URL when available
    if (substr($_[4],0,7) eq 'http://') {
        $post_url = $_[4];
    } else {
        #Use add host and port for relative URLs
        $post_url = $SoapHeaders::http_prefix . $_[0] . $SoapHeaders::separator . $_[1] . $_[4];
    }

    #print $post_url;
    my $user_agent = LWP::UserAgent->new();
    $user_agent->agent($user_agent->_agent . ' DLNADOC/1.50');
    my $soap_request = HTTP::Request->new(POST => $post_url);
    $soap_request->header(SOAPAction => $_[3]);
    $soap_request->content($_[2]);
    $soap_request->content_type($SoapHeaders::content_type);

    my $soap_response = $user_agent->request($soap_request);
    return $soap_response;
}

1;

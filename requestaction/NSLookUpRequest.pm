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

package NSLookUpRequest;
use utils::SocketCalls;

our $nslookup_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#NSLookup\"";
our $nslookup_request_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
         <u:NSLookup xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <HostName>";
our $host_nslookup = "127.0.0.1";
our $nslookup_request_message2="</HostName>
         <DNSServer />
         <NumberOfRepetitions>0</NumberOfRepetitions>
         <Timeout>0</Timeout>
      </u:NSLookup>
   </s:Body>
</s:Envelope>";

sub nslookup_request {
 my $host_value = "";
 if ($_[2] eq '') {
     $host_value = $host_value . $host_nslookup;
 } else {
     $host_value = $host_value . $_[2];
 }
 return SocketCalls::invoke_soap_request($_[0], $_[1], $nslookup_request_message1 . $host_value . $nslookup_request_message2, $nslookup_action);
}

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

use strict;
use Switch;

# Use the module
use utils::Util;
use utils::SocketCalls;
use include::ActionRequestInclude;
use include::ActionResponseInclude;
use ResponseValidator;

while (1) {
Util::print_diagc_start;
our ($OPTION, $HOSTIP, $HOSTPORT) = Util::get_user_input;

    switch($OPTION){
       case 1          {
                        my $devicestatus_response = DeviceStatusRequest::devicestatus_request($HOSTIP, $HOSTPORT);
                        ResponseValidator::valiate_soap_response($devicestatus_response);
                       }
       case 2          {
                        print "Enter the Test number for CancelTest : ";
                        my $TESTID = <>;
                        chomp $TESTID;
                        my $canceltest_response = CancelTestRequest::canceltest_request($HOSTIP, $HOSTPORT, $TESTID);
                        ResponseValidator::valiate_soap_response($canceltest_response);
                       }
       case 3          {
                        my $activetestids_response = GetActiveTestIDsRequest::activetestids_request($HOSTIP, $HOSTPORT);
                        ResponseValidator::valiate_soap_response($activetestids_response);
                       }
       case 4          {
                        print "Enter the HostName to perform NSLookup : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $nslookup_req_response = NSLookUpRequest::nslookup_request($HOSTIP, $HOSTPORT, $HOST_NAME);
                        ResponseValidator::valiate_soap_response($nslookup_req_response);
                       }
       case 5          {
                        print "Enter the HostName to perform Ping : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $ping_req_response = PingRequest::ping_request($HOSTIP, $HOSTPORT, $HOST_NAME);
                        ResponseValidator::valiate_soap_response($ping_req_response);
                       }
       case 6          {
                        print "Enter the HostName to perform traceroute : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $traceroute_req_request = TracerouteRequest::traceroute_request($HOSTIP, $HOSTPORT, $HOST_NAME);
                        ResponseValidator::valiate_soap_response($traceroute_req_request);
                       }
       case 7          {
                        my $testidsreq_response = TestIDsRequest::testids_request($HOSTIP, $HOSTPORT);
                        ResponseValidator::valiate_soap_response($testidsreq_response);
                       }
       case 8          {
                        print "Enter the Test number for TestInfo : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $testinfo_response = TestInfoRequest::testinfo_request($HOSTIP, $HOSTPORT, $TESTID_INFO);
                        ResponseValidator::valiate_soap_response($testinfo_response);
                       }
       case 9          {
                        print "Enter the Test number for GetNSLookupResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $nslookup_res_response = NSLookUpResponse::nslookup_response($HOSTIP, $HOSTPORT, $TESTID_INFO);
                        ResponseValidator::valiate_soap_response($nslookup_res_response);
                       }
       case 10         {
                        print "Enter the Test number for GetPingResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $ping_res_response = PingResponse::ping_response($HOSTIP, $HOSTPORT, $TESTID_INFO);
                        ResponseValidator::valiate_soap_response($ping_res_response);
                       }
       case 11         {
                        print "Enter the Test number for GetTracerouteResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $traceroute_res_response = TracerouteResponse::traceroute_response($HOSTIP, $HOSTPORT, $TESTID_INFO);
                        ResponseValidator::valiate_soap_response($traceroute_res_response);
                       }
       case ('x')      { exit; }
    }
}
1;

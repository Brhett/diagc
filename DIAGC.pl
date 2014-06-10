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
#

use strict;
use Switch;

# Use the module
use utils::Util;
use utils::SocketCalls;
use include::ActionRequestInclude;
use include::ActionResponseInclude;
use include::UPnPInclude;
use responsevalidator::ResponseValidator;

START:

our ($TEST_OPTION, $HOSTIP, $HOSTPORT, $CONTROL_URL) = '';

print "\33[1;33m------- Choose an option -------\33[m\n";
print "1. Search DIAGE capable devices \n";
print "2. Manual DIAGE device testing \n";
print "3. Exit Application \n";
print "\33[1;33mEnter the option number : \33[m";
our $SEARCH_OPTS = <>;
chomp $SEARCH_OPTS;

switch($SEARCH_OPTS){
       case 1          {
                        my ($diage_devices, $diage_ip, $diage_port, $control_url) = SearchDevices::lookup_diage_device;
                        print "\33[1;33mChoose the corresponding device number to start testing: \33[m\n";

                        my $device_count=0;
                        print "****************************************\n";
                        print "****************************************\n";

                        foreach my $device_temp (@$diage_devices) {
                            print "----------------------------------------\33[m\n";
                            print "\33[1;33m[" . ($device_count + 1) . "] : " . $device_temp->getfriendlyname() . "\33[m\n";
                            print "\33[1;33mDevice IP : " . @$diage_ip[$device_count] . "\33[m\n";
                            print "\33[1;33mDevice Port : " . @$diage_port[$device_count] . "\33[m\n";
                            print "\33[1;33mControl URL : " . @$control_url[$device_count] . "\33[m\n";
                            $device_count++;
                        }

                        print "****************************************\n";
                        print "****************************************\n";

                        print "\33[1;33mChoose the device number: \33[m";
                        my $DEVICE_NO = <>;
                        chomp $DEVICE_NO;

                        $HOSTIP = @$diage_ip[$DEVICE_NO - 1];
                        $HOSTPORT = @$diage_port[$DEVICE_NO - 1];
                        $CONTROL_URL = @$control_url[$DEVICE_NO - 1];
                        Util::print_diagc_start;
                       }
       case 2          {
                        Util::print_diagc_start;
                       }                       
       case 3          {
                        exit;
                       }
       else            { exit;}  
       
}

while (1) {
GET_USER_OPT:
    $TEST_OPTION = Util::get_user_options;
    if ($SEARCH_OPTS eq '2') {
      ($HOSTIP, $HOSTPORT, $CONTROL_URL) = Util::get_manual_device_details;
    }

    switch($TEST_OPTION){
       case 1          {
                        my $devicestatus_response = DeviceStatusRequest::devicestatus_request($HOSTIP, $HOSTPORT, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($devicestatus_response);
                       }
       case 2          {
                        print "Enter the Test number for CancelTest : ";
                        my $TESTID = <>;
                        chomp $TESTID;
                        my $canceltest_response = CancelTestRequest::canceltest_request($HOSTIP, $HOSTPORT, $TESTID, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($canceltest_response);
                       }
       case 3          {
                        my $activetestids_response = GetActiveTestIDsRequest::activetestids_request($HOSTIP, $HOSTPORT, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($activetestids_response);
                       }
       case 4          {
                        print "Enter the HostName to perform NSLookup : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $nslookup_req_response = NSLookUpRequest::nslookup_request($HOSTIP, $HOSTPORT, $HOST_NAME, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($nslookup_req_response);
                       }
       case 5          {
                        print "Enter the HostName to perform Ping : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $ping_req_response = PingRequest::ping_request($HOSTIP, $HOSTPORT, $HOST_NAME, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($ping_req_response);
                       }
       case 6          {
                        print "Enter the HostName to perform traceroute : ";
                        my $HOST_NAME = <>;
                        chomp $HOST_NAME;
                        my $traceroute_req_request = TracerouteRequest::traceroute_request($HOSTIP, $HOSTPORT, $HOST_NAME, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($traceroute_req_request);
                       }
       case 7          {
                        my $testidsreq_response = TestIDsRequest::testids_request($HOSTIP, $HOSTPORT, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($testidsreq_response);
                       }
       case 8          {
                        print "Enter the Test number for TestInfo : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $testinfo_response = TestInfoRequest::testinfo_request($HOSTIP, $HOSTPORT, $TESTID_INFO, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($testinfo_response);
                       }
       case 9          {
                        print "Enter the Test number for GetNSLookupResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $nslookup_res_response = NSLookUpResponse::nslookup_response($HOSTIP, $HOSTPORT, $TESTID_INFO, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($nslookup_res_response);
                       }
       case 10         {
                        print "Enter the Test number for GetPingResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $ping_res_response = PingResponse::ping_response($HOSTIP, $HOSTPORT, $TESTID_INFO, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($ping_res_response);
                       }
       case 11         {
                        print "Enter the Test number for GetTracerouteResult : ";
                        my $TESTID_INFO = <>;
                        chomp $TESTID_INFO;
                        my $traceroute_res_response = TracerouteResponse::traceroute_response($HOSTIP, $HOSTPORT, $TESTID_INFO, $CONTROL_URL);
                        ResponseValidator::valiate_soap_response($traceroute_res_response);
                       }
       case ('x')      { goto START; }
       else            { goto GET_USER_OPT; }
    }
    Util::print_diagc_start;
}

1;

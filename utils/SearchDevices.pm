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
package SearchDevices;

use utils::UPnPWrapper;
use Net::UPnP::Device;
use Net::UPnP::ControlPoint;

sub search_devices {
    my ($devices, $ip, $port) = UPnPWrapper::search();
    print "Total Devices found on network : " .@$devices . "\n";
    return ($devices, $ip, $port);
}

sub lookup_diage_device {
    my ($device_list_search, $device_ip_list, $device_port_list) = search_devices;
    $devNum= 0;
    my (@temp_device_list, @temp_device_ip, @temp_device_port)= ();
    foreach my $dev_temp (@$device_list_search) {
        unless ($dev_temp->getservicebyname('urn:schemas-upnp-org:service:BasicManagement:2')) {
            $devNum++;
            next;
        }
        push (@temp_device_list , $dev_temp);
        push (@temp_device_ip, @$device_ip_list[$devNum]);
        push (@temp_device_port, @$device_port_list[$devNum]);
#        print "[" . ($devNum + 1) . "] : " . $dev_temp->getfriendlyname() . "\n";
#        print "Device IP : " . @$device_ip_list[$devNum] . "\n";
#        print "Device Port : " . @$device_port_list[$devNum] . "\n";
        $devNum++;
    }
    print "Devices with DIAGE capability: " . @temp_device_list . "\n";
    return (\@temp_device_list, \@temp_device_ip, \@temp_device_port);
}

1;
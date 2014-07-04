#!/usr/bin/perl

package UPnPWrapper;

use strict;

use Socket;
use Net::UPnP;
use Net::UPnP::HTTP;
use Net::UPnP::Device;

use threads;

my $ssdp_multicast_msg = sockaddr_in($Net::UPnP::SSDP_PORT, inet_aton($Net::UPnP::SSDP_ADDR));
my $ssdp_header = "M-SEARCH * HTTP/1.1\r\nHOST: $Net::UPnP::SSDP_ADDR:$Net::UPnP::SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: 5\r\nST: upnp:rootdevice\r\n\r\n";
#my $ssdp_header = "M-SEARCH * HTTP/1.1\r\nST: upnp:rootdevice\r\nMan: \"ssdp:discover\"\r\nMX: 5\r\nHost: $Net::UPnP::SSDP_ADDR:$Net::UPnP::SSDP_PORT\r\n\r\n";

# The below format fails in some clients. But keeping it for now.
#my $ssdp_header = "M-SEARCH * HTTP/1.1\r\n
#ST: upnp:rootdevice\r\n
#Man: \"ssdp:discover\"\r\n
#MX: 5\r\n
#Host: $Net::UPnP::SSDP_ADDR:$Net::UPnP::SSDP_PORT\r\n\r\n";


sub sendThread {
    socket(SSDP_SOCK, AF_INET, SOCK_DGRAM, getprotobyname('udp'));
    send(SSDP_SOCK, $ssdp_header, 0, $ssdp_multicast_msg);
}

sub search {
# Few clients don't understand the HOST header.

print "******************** SSDP Message ********************\n";
print $ssdp_header;
print "******************** SSDP Message ********************\n";

# Count 1 : Send out SSDP message
socket(SSDP_SOCK, AF_INET, SOCK_DGRAM, getprotobyname('udp'));
send(SSDP_SOCK, $ssdp_header, 0, $ssdp_multicast_msg);

# Count 9 : Due to the unreliable nature of UDP,
#           control points should send each M-SEARCH message more than once,
#           not to exceed 10 M-SEARCH requests in a 200 ms period.
for (my $count = 1; $count <= 9; $count++) {
        threads->new(\&sendThread, $count);
}

my @device_list=();
my @device_addr=();
my @device_port=();

my ($reader_input, $reader_output, $ssdp_res_msg, $ssdp_response) = '';
vec($reader_input, fileno(SSDP_SOCK), 1) = 1;
while( select($reader_output = $reader_input, undef, undef, 10) ) {
        recv(SSDP_SOCK, $ssdp_response, 4096, 0);
        print "\33[1;32m" . $ssdp_response . "\33[m\n";

        unless ($ssdp_response =~ m/LOCATION[ :]+(.*)\r/i) {
                next;
        }
        my $location = $1;

        unless ($location =~ m/http:\/\/([0-9a-z.]+)[:]*([0-9]*)\/(.*)/i) {
                next;
        }
        my $host_address = $1;
        my $host_port = $2;
        my $dev_path = '/' . $3;

        # Using LWP::UserAgent improves the response time
        print "Waiting for SSDP response..... \n\n";
        my $get_url = $SoapHeaders::http_prefix . $host_address . $SoapHeaders::separator . $host_port . $dev_path;
        my $user_agent = LWP::UserAgent->new(keep_alive => 1);

        my $get_request = HTTP::Request->new(GET => $get_url);
        $get_request->protocol('HTTP/1.1');
        my $get_response = $user_agent->request($get_request);
        my $get_content;
        if ( index($get_response->as_string, "154 Continue") != -1) {
            # Fall back to curl since LWP does not have support for 154 Continue
            $get_content = `curl $get_url`;
        } else {
            $get_content = $get_response->content;
        }

        # print $get_content;

        # Keeping this in here for now. The performance of below code using plain HTTP:Request is slow.
        #my $http_request = Net::UPnP::HTTP->new();
        #print "Waiting for SSDP response..... \n\n";
        #my $post_response = $http_request->post($host_address, $host_port, "GET", $dev_path, "", "");

        #my $get_content = $post_response->getcontent();
        #print $get_content;

        my $dev = Net::UPnP::Device->new();
        $dev->setssdp($ssdp_response);

        # Handle Chunked response from server in a traditional way.
        # If not using LWP::UserAgent, chunked responses will be handled this way.
        if (index(lc($get_content),"transfer-encoding: chunked") != -1) {
            $get_content = substr($get_content,index($get_content,"<?xml version=\"1.0\"") ,length($get_content));

            # Open the file to write
            my $filename = 'temp.txt';
            open(my $fw, '>', $filename) or die "Could not open file '$filename' $!";
            print $fw $get_content;
            # Close the file
            close $fw;

            # Open the file to read
            open(my $fr, '<', $filename) or die "Could not open file '$filename' $!";
            my $chunked_content;
            while (<$fr>) {
              my $replace_str = $_;
              $replace_str =~ s/^([0-9]+)\r\n//;
              print $replace_str;
              $chunked_content .= $replace_str;
            }
            $chunked_content =~ s/\r\n//g;
            $dev->setdescription($chunked_content);
            # Close the file
            close $fr;
        } else {
            # Non-Chunked response.
            $dev->setdescription($get_content);
        }

        push(@device_list, $dev);
        push(@device_addr,$host_address);
        push(@device_port,$host_port);
}
close(SSDP_SOCK);

# Multiple arrays cannot be passed by value., If passed then all the values will be dumped into the first array
# So return the array references. And also use my qualifier, so that a new instance will be created where it is assigned.
return ( \@device_list, \@device_addr, \@device_port);
}

1;

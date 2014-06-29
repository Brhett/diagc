#!/usr/bin/perl

package UPnPWrapper;

use strict;

use Socket;
use Net::UPnP;
use Net::UPnP::HTTP;
use Net::UPnP::Device;

sub search {
# Few clients don't understand the HOST header.
#my $ssdp_header = "M-SEARCH * HTTP/1.1\r\nST: upnp:rootdevice\r\nMan: \"ssdp:discover\"\r\nMX: 5\r\nHost: $Net::UPnP::SSDP_ADDR:$Net::UPnP::SSDP_PORT\r\n\r\n";

my $ssdp_header = "M-SEARCH * HTTP/1.1\r\nST: upnp:rootdevice\r\nMan: \"ssdp:discover\"\r\nMX: 5\r\n\r\n";

# The below format fails in some clients. But keeping it for now.
#my $ssdp_header = "M-SEARCH * HTTP/1.1\r\n
#ST: upnp:rootdevice\r\n
#Man: \"ssdp:discover\"\r\n
#MX: 5\r\n
#Host: $Net::UPnP::SSDP_ADDR:$Net::UPnP::SSDP_PORT\r\n\r\n";

print "******************** SSDP Message ********************\n";
print $ssdp_header;
print "******************** SSDP Message ********************\n";

socket(SSDP_SOCK, AF_INET, SOCK_DGRAM, getprotobyname('udp'));
my $ssdp_multicast_msg = sockaddr_in($Net::UPnP::SSDP_PORT, inet_aton($Net::UPnP::SSDP_ADDR));
send(SSDP_SOCK, $ssdp_header, 0, $ssdp_multicast_msg);

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

        my $http_request = Net::UPnP::HTTP->new();
        print "Waiting for SSDP response..... \n\n";
        my $post_response = $http_request->post($host_address, $host_port, "GET", $dev_path, "", "");

        my $post_content = $post_response->getcontent();
        #print $post_content;

        my $dev = Net::UPnP::Device->new();
        $dev->setssdp($ssdp_response);

        # Handle Chunked response from server.
        if (index(lc($post_content),"transfer-encoding: chunked") != -1) {
            $post_content = substr($post_content,index($post_content,"<?xml version=\"1.0\" encoding=\"utf-8\" ?>") ,length($post_content));
            my $filename = 'temp.txt';
            open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";
            my $chunked_content;
            while (<$fh>) {
              my $replace_str = $_;
              $replace_str =~ s/^([0-9]+)\r\n//;
              #print $replace_str;
              $chunked_content .= $replace_str;
            }
            $chunked_content =~ s/\r\n//g;

            $dev->setdescription($chunked_content);

            # Close and delete the file
            close $fh;
            unlink $fh;
        } else {
            # Non-Chunked response.
            $dev->setdescription($post_content);
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

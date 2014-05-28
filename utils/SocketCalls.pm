#!/usr/bin/perl
package SocketCalls;

use utils::SoapHeaders qw( );
use LWP::UserAgent;
use HTTP::Request;

sub invoke_soap_request {
    #print "The passed IP Address :" . $_[0] . "\n";
    #print "The passed port no :" . $_[1] . "\n";
    #print "Request Message : " . $_[2] . "\n";
    #print "Soap Action :".$_[3] . "\n";
    my $post_url = $SoapHeaders::http_prefix . $_[0] . $SoapHeaders::separator . $_[1] . $SoapHeaders::control_url;
    print $post_url;
    my $user_agent = LWP::UserAgent->new();
    my $soap_request = HTTP::Request->new(POST => $post_url);
    $soap_request->header(SOAPAction => $_[3]);
    $soap_request->content($_[2]);
    $soap_request->content_type($SoapHeaders::content_type);

    my $soap_response = $user_agent->request($soap_request);
    return $soap_response;
}

1;

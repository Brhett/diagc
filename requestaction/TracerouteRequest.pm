#!/usr/bin/perl
package TracerouteRequest;
use utils::SocketCalls;

our $traceroute_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#Traceroute\"";
our $traceroute_request_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:Traceroute xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <Host>";
our $host_ping = "127.0.0.1";
our $traceroute_request_message2="</Host>
         <Timeout>0</Timeout>
         <DataBlockSize>0</DataBlockSize>
         <MaxHopCount>0</MaxHopCount>
         <DSCP>0</DSCP>
      </u:Traceroute>
   </s:Body>
</s:Envelope>";

sub traceroute_request {
 my $host_value = "";
 if ($_[2] eq '') {
	 $host_value = $host_value . $host_ping;
 } else {
	 $host_value = $host_value . $_[2];
 }
 return SocketCalls::invoke_soap_request($_[0], $_[1], $traceroute_request_message1 . $host_value . $traceroute_request_message2, $traceroute_action);
}

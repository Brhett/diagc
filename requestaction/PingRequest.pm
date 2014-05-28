#!/usr/bin/perl
package PingRequest;
use utils::SocketCalls;

our $ping_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#Ping\"";
our $ping_request_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
<s:Body>
      <u:Ping xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <Host>";
our $host_ping = "127.0.0.1";
our $ping_request_message2="</Host>
         <NumberOfRepetitions>0</NumberOfRepetitions>
         <Timeout>0</Timeout>
         <DataBlockSize>0</DataBlockSize>
         <DSCP>0</DSCP>
      </u:Ping>
   </s:Body>
</s:Envelope>";

sub ping_request {
 my $host_value = "";
 if ($_[2] eq '') {
	 $host_value = $host_value . $host_ping;
 } else {
	 $host_value = $host_value . $_[2];
 }
 return SocketCalls::invoke_soap_request($_[0], $_[1], $ping_request_message1 . $host_value . $ping_request_message2, $ping_action);
}

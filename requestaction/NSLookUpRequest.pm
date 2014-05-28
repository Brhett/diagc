#!/usr/bin/perl
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

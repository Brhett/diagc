#!/usr/bin/perl
package PingResponse;
use utils::SocketCalls;

our $ping_response_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetPingResult\"";
our $ping_response_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetPingResult xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <TestID>";
our $ping_response_message2="</TestID>
      </u:GetPingResult>
   </s:Body>
</s:Envelope>";

sub ping_response {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $ping_response_message1 . $_[2] . $ping_response_message2, $ping_response_action);
}

#!/usr/bin/perl
package TracerouteResponse;
use utils::SocketCalls;

our $traceroute_response_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetTracerouteResult\"";
our $traceroute_response_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetTracerouteResult xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <TestID>";
our $traceroute_response_message2="</TestID>
      </u:GetTracerouteResult>
   </s:Body>
</s:Envelope>";

sub traceroute_response {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $traceroute_response_message1 . $_[2] . $traceroute_response_message2, $traceroute_response_action);
}

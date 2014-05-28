#!/usr/bin/perl
package NSLookUpResponse;
use utils::SocketCalls;

our $nslookup_response_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetNSLookupResult\"";
our $nslookup_response_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetNSLookupResult xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <TestID>";
our $nslookup_response_message2="</TestID>
      </u:GetNSLookupResult>
   </s:Body>
</s:Envelope>";

sub nslookup_response {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $nslookup_response_message1 . $_[2] . $nslookup_response_message2, $nslookup_response_action);
}

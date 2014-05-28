#!/usr/bin/perl
package TestInfoRequest;
use utils::SocketCalls;

our $testinfo_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetTestInfo\"";
our $testinfo_request_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetTestInfo xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <TestID>";
our $testinfo_request_message2="</TestID>
      </u:GetTestInfo>
   </s:Body>
</s:Envelope>";

sub testinfo_request {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $testinfo_request_message1 . $_[2] . $testinfo_request_message2, $testinfo_action);
}

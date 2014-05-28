#!/usr/bin/perl
package CancelTestRequest;
use utils::SocketCalls;

our $canceltest_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#CancelTest\"";
our $canceltest_request_message1 = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
         <u:CancelTest xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\">
         <TestID>";
our $canceltest_request_message2="</TestID>
      </u:CancelTest>
   </s:Body>
</s:Envelope>";

sub canceltest_request {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $canceltest_request_message1 . $_[2] . $canceltest_request_message2, $canceltest_action);
}

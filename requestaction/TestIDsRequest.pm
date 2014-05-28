#!/usr/bin/perl
package TestIDsRequest;
use utils::SocketCalls;

our $testids_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetTestIDs\"";
our $testids_request_message = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetTestIDs xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\" />
   </s:Body>
</s:Envelope>";

sub testids_request {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $testids_request_message, $testids_action);
}

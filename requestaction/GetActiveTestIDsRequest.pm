#!/usr/bin/perl
package GetActiveTestIDsRequest;
use utils::SocketCalls;

our $activetestids_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetActiveTestIDs\"";
our $activetestids_request_message = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
       <u:GetActiveTestIDs xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\" />
   </s:Body>
</s:Envelope>";

sub activetestids_request {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $activetestids_request_message, $activetestids_action);
}

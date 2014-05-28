#!/usr/bin/perl
package DeviceStatusRequest;
use utils::SocketCalls;

our $devicestatus_action = "\"urn:schemas-upnp-org:service:BasicManagement:2#GetDeviceStatus\"";
our $devicestatus_request_message = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
<s:Envelope s:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\">
   <s:Body>
      <u:GetDeviceStatus xmlns:u=\"urn:schemas-upnp-org:service:BasicManagement:2\" />
   </s:Body>
</s:Envelope>";

sub devicestatus_request {
 return SocketCalls::invoke_soap_request($_[0], $_[1], $devicestatus_request_message,$devicestatus_action);
}

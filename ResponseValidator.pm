#!/usr/bin/perl
package ResponseValidator;

sub valiate_soap_response {
    my $soap_response = $_[0];
    #if($soap_response->code == 200) {
        print $soap_response->as_string;
    #}
    #else {
    #    print $soap_response->as_string;
    #}
}

1;

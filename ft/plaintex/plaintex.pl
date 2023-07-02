#!/bin/env perl

use MIME::Base64;
#open(IMAGE, "texput.png") or die "Can not open png";
$raw_string = do{local $/ = undef; <>;};
print(MIME::Base64::encode_base64($raw_string));
close IMAGE

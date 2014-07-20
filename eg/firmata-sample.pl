#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Device::Firmata;
use Device::Firmata::Constants qw/:all/;
use Time::HiRes qw/sleep/;

use constant {
    LED_PIN => 13
};

my $device = Device::Firmata->open("/dev/cu.usbserial-A600acKz");
$device->pin_mode(LED_PIN, PIN_OUTPUT);

for my $i (1..1000) {
    $device->digital_write(LED_PIN, $i % 2);
    sleep rand() / 100;
}
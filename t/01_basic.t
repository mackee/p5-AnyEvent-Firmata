use strict;
use warnings;
use Test::More skip_all => "no implement";

use AnyEvent::Firmata qw/:all/;

my $serial_port = "/dev/cu.usbserial-A600acKz";
my $device = AnyEvent::Firmata->open(
    $serial_port,
    pin_modes => {
        13 => PIN_OUTPUT,
        12 => PIN_INPUT,
        11 => PIN_INPUT,
        10 => PIN_OUTPUT,
        5  => PIN_INPUT,
    },
);

subtest "digital_write" => sub {
    plan tests => 1;
    $device->digital_write(13 => 1, sub {
        pass;
    });
};

subtest "digital_read" => sub {
    plan tests => 1;
    $device->digital_read(12 => sub {
        my $state = shift;
        ok $state;
    });
};

subtest "digital_read with timeout" => sub {
    plan tests => 1;
    $device->digital_read(11 => sub {
        fail;
    },
    timeout => 10,
    on_timeout => sub {
        pass;
    });
};

subtest "analog_write" => sub {
    plan tests => 1;
    $device->analog_write(10 => 128, sub {
        pass;
    });
};

subtest "analog_read" => sub {
    plan tests => 1;
    $device->analog_write(5 => sub {
        my $analog_value = shift;
        is $analog_value, 512;
    });
};
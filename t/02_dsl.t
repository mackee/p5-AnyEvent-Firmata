use strict;
use warnings;
use Test::More skip_all => "no implement";

use AnyEvent;
use AnyEvent::Firmata::DSL qw/:all/;

my $device = behavior {
    pin_modes +{
        13 => PIN_OUTPUT,
        12 => PIN_INPUT,
        11 => PIN_INPUT,
        10 => PIN_OUTPUT,
        5  => PIN_INPUT,
    };

    digital_write 13 => HIGH;

    my $i = 0;
    on_state 13, sub {
        my $state = shift;
        $i++;
        end_run if $i == 10;
        digital_write 13 => HIGH;
    },
    after => 1;

    on_state 12 => HIGH, sub {
        pass;
    };

    on_state 11 => HIGH, sub {
        my $state = shift;
        ok $state;
    },
    timeout => 10,
    on_timeout => sub {
        my $self = shift;
        $self->destroy_emitter;
    };

    analog_write 10 => 128;

    on_analog 5 => sub {
        my $analog_value = shift;
        is $analog_value => 512;
    };
};

$device->run;
pass;
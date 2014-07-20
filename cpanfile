requires 'perl', '5.008001';
requires 'Device::Firmata', '>= 0.60';
requires 'Device::SerialPort', '>= 1.04';

on 'test' => sub {
    requires 'Test::More', '0.98';
};


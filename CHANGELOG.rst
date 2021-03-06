sc_i2s Change Log
=================

1.6.0
-----
    - RESOLVED:   LR clock not aligned properly due as it was set to be driven at 31 but then not
                  driven again until after 64 clock ticks. This meant that it would be aligned to
                  the instruction stream rather than clock edges as desired. The fix keeps the 
                  output buffer full to ensure that it keeps the initial alignment.

1.5.0
-----
    - RESOLVED:   ADC samples over the channel interface were misaligned.  Instead of the
                  expected left/right channel sequence: (l1, r1) ... (l2, r2) ... (l3, r3)
                  the following order was returned:(r1, l2) ... (r2, l3) ... (r3, l4)
                  This was resolved by by rotating the main loop such that the port I/O
                  syncs with the channel I/O.

    * Changes to dependencies:

    - sc_i2c: 2.2.1rc0 -> 2.4.1rc0

      + module_i2c_simple header-file comments updated to correctly reflect API
      + module_i2c_simple can now be built with support to send repeated starts and retry reads and writes NACKd by slave
      + module_i2c_shared added to allow multiple logical cores to safely share a single I2C bus
      + Removed readreg() function from single_port module since it was not safe

1.4.3
-----
    - Dependancy update only

1.4.2
-----
    - Dependancy update only

1.4.1
-----
    - More documentation and code updates following review

1.4.0
-----
    - Updates to components and documents for slicekit and xSOFTip

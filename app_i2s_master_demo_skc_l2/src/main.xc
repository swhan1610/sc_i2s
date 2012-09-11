// Copyright (c) 2011, XMOS Ltd., All rights reserved
// This software is freely distributable under a derivative of the
// University of Illinois/NCSA Open Source License posted in
// LICENSE.txt and at <http://github.xcore.com/>

#include <platform.h>
#include <xclib.h>
#include <assert.h>
#include <print.h>
#include <stdlib.h>
#include "i2c.h"
#include "codec.h"
#include "processing.h"

#include "app_global.h"

//::declaration
#include "i2s_master.h"

on stdcore[1] : struct r_i2s r_i2s =
{
    XS1_CLKBLK_1,
    XS1_CLKBLK_2,
    PORT_MCLK_IN,             // Master Clock 
    PORT_I2S_BCLK,            // Bit Clock
    PORT_I2S_LRCLK,           // LR Clock
    {PORT_I2S_ADC0, PORT_I2S_ADC1},
    {PORT_I2S_DAC0, PORT_I2S_DAC1},

};
//::

/* Port for I2C bus.  Both SDA and SCL on same port */
on stdcore[1] : port p_i2c = PORT_I2C;

/* GPIO port */
on stdcore[1] : out port p_gpio = PORT_GPIO;


void audio_hw_init()
{
    /* Initialise the I2C bus */
    i2c_master_init(p_i2c);
}


void audio_hw_config(unsigned samFreq)
{
    /* Setup the CODEC for use. Note we do this everytime since we reset CODEC on SF change */
    codec_config(samFreq, MCLK_FREQ);

}


//::main program
int main()
{
   streaming chan c_data;
   par 
    {
        on stdcore[1] : 
        {
            audio_hw_init();

            while(1)
            {
                audio_hw_config(48000);           
                i2s_master(r_i2s, c_data);
            }
        }

        on stdcore[1] : processing(c_data);

    }
   return 0;
}
//::
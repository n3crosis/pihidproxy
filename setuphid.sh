#!/bin/bash
cd /sys/kernel/config/usb_gadget/
mkdir -p piproxy
cd piproxy
echo 0x1d6b > idVendor # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB # USB2
mkdir -p strings/0x409
echo "fedcba9876543210" > strings/0x409/serialnumber
echo "Raspberry Pi" > strings/0x409/manufacturer
echo "pizero keyboard Device" > strings/0x409/product
mkdir -p configs/c.1/strings/0x409
echo "Config 1: ECM network" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

# Add functions here

#keyboard
mkdir -p functions/hid.usb0
echo 1 > functions/hid.usb0/protocol
echo 1 > functions/hid.usb0/subclass
echo 8 > functions/hid.usb0/report_length
echo -ne \\x05\\x01\\x09\\x06\\xa1\\x01\\x05\\x07\\x19\\xe0\\x29\\xe7\\x15\\x00\\x25\\x01\\x75\\x01\\x95\\x08\\x81\\x02\\x95\\x01\\x75\\x08\\x81\\x03\\x95\\x05\\x75\\x01\\x05\\x08\\x19\\x01\\x29\\x05\\x91\\x02\\x95\\x01\\x75\\x03\\x91\\x03\\x95\\x06\\x75\\x08\\x15\\x00\\x25\\x65\\x05\\x07\\x19\\x00\\x29\\x65\\x81\\x00\\xc0 > functions/hid.usb0/report_desc
ln -s functions/hid.usb0 configs/c.1/

# mouse
mkdir -p functions/hid.usb1
echo 2 > functions/hid.usb1/protocol
echo 1 > functions/hid.usb1/subclass
echo 4 > functions/hid.usb1/report_length
echo -ne \\0x05\\0x01\\0x09\\0x02\\0xa1\\0x01\\0x09\\0x01\\0xa1\\0x00\\0x85\\0x01\\0x05\\0x09\\0x19\\0x01\\0x29\\0x03\\0x15\\0x00\\0x25\\0x01\\0x95\\0x03\\0x75\\0x01\\0x81\\0x02\\0x95\\0x01\\0x75\\0x05\\0x81\\0x03\\0x05\\0x01\\0x09\\0x30\\0x09\\0x31\\0x09\\0x38\\0x15\\0x81\\0x25\\0x7f\\0x75\\0x08\\0x95\\0x03\\0x81\\0x06\\0xc0\\0xc0 > functions/hid.usb1/report_desc
ln -s functions/hid.usb1 configs/c.1/
# End functions

ls /sys/class/udc > UDC


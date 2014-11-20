> **Current Version: 1.0**

About IPSync
============
> IPSync is a tool designed to keep track of all of those nasty little dynamic
> public IP addresses connected to our home networks. It works by keeping a 
> database of all of your servers' IP addresses, updating the databases when
> any one of your device's IP addresses changes and notifiying you of the 
> change so that you can make the changes that you need to make.

Usage of IPSync
===============
> At the moment, the project is a little lame. It exsists only as a shell script
> and currently doesn't do notifications beyond the command line. That being said,
> To use it in it's current state, do the following:
1. Download *IPSync.sh* to your computer
2. Assuming that you're using linux, type *chmod +x IPSync.sh*
3. Excute the script by typing *./IPSync.sh*
> The script requires two files, a devicename file (*device.name*), and an IP
> address database (*IPSync.db*). Removal of any of these files will result in 
> IPSync recreating them. When you run the program for the first time, it will 
> prompt you for a device name and create the devicename file for you. It will 
> also create the IP database for you.

Future Plans for IPSync
=======================
- Move away from a shell script to a daemon
- Add alternative notification methods (Growl, Pushover, email, etc.)
- Change the DNS records for the associated hostnames of the devices
- Make DynDNS superfulous --> **TAKE OVER THE WORLD**

Syntax of Required Files
========================
> Below you'll find how the required files are created/designed so you can manually
> edit them, if you really want to.
>
> > *device.name*
> > Sample Entry:
> > > DeviceName
> >
> > This file should only contain one word and one line. This one word should be the
> > device's name. The program currently differeniates between lowercase and uppercase
> > devicenames.
>
> > *IPSync.db*
> > Sample Entry:
> > > DeviceName : 0.0.0.0
> >
> > This file should have one device per line and be of the form shown above.
>
> Both the devicename and IP database filenames are changeable through the the IPSync
> script. If you fail to change the names of your exisiting files, IPSync will create
> new ones. You are also able to change the delimiter used in the IP database, not that
> that has much of a purpose other than to be aesthetically pleasing.

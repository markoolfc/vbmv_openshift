==========
VirtualBMC for Openshift CNV
==========

Supported IPMI commands
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: bash

  # Power the virtual machine on, off, graceful off, NMI and reset
  ipmitool -I lanplus -U admin -P password -H 127.0.0.1 power on|off

  # Check the power status
  ipmitool -I lanplus -U admin -P password -H 127.0.0.1 power status



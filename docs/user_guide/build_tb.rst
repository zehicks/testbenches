.. _build_tb:

Build a test bench
===============================================================================

**Please note that ADI only provides the source files necessary to create and 
build the designs. This means that you are responsible for modifying and
building these projects.**

Here, we are giving you a quick rundown on how we build things. That said,
the steps below are **not a recommendation**, but a suggestion.
How you want to build these projects is entirely up to you.
The only catch is that if you run into problems, you have to resolve them independently.

The build process depends on certain software and tools, which you could use in
many ways. We use **command line** and mostly **Linux systems**. On Windows, we
use **Cygwin**.

Setup and check your environment
-------------------------------------------------------------------------------

This section contains a guide about how to set up your environment to build any
test bench from the repository:

#. Install the required FPGA design suite. We use `AMD Xilinx Vivado`_.
   You can find information about the proper version in our
   `release notes <https://github.com/analogdevicesinc/hdl/releases>`__.
   Make sure that you're always using the latest release.
#. The proper Vivado version can be found in:

   -  Starting with ``hdl_2021_r1`` release branch:
      :git-hdl:`scripts/adi_env.tcl`
   -  For ``hdl_2019_r2`` and older:
      :git-hdl:`hdl/projects/scripts/adi_project_xilinx.tcl <hdl_2019_r2:projects/scripts/adi_project_xilinx.tcl>` for Vivado.

#. Download the tools from the following link:

   -  `AMD tools <https://www.xilinx.com/support/download.html>`__ (make sure you're
      downloading the proper installer. For full installation, it is
      better to choose the one that downloads and installs both Vivado
      and Vitis at the same time)

#. After you have installed the above-mentioned tools, you will need the
   paths to those directories in the following steps, so have them in a
   note.
#. We are using `git <https://git-scm.com/>`__ for version control and
   `GNU Make <https://www.gnu.org/software/make/>`__ to build the
   projects. Depending on what OS you're using, you have these options:

.. collapsible::  For Windows environment with Cygwin

   Because GNU Make is not supported on Windows, you need to install
   `Cygwin <https://www.cygwin.com/>`__, which is a UNIX-like environment
   and command-line interface for Microsoft Windows. You do not need to
   install any special package, other than ``git`` and ``make``.

   After you have installed Cygwin, you need to add your FPGA Design Tools
   installation directory to your PATH environment variable. You can do
   that by modifying your **.bashrc** file, by adding the following lines
   (**changed accordingly to your installation directories**). For example:

   .. code-block:: bash
      :linenos:

      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vivado/202x.x/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vivado_HLS/202x.x/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/gnu/microblaze/nt/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/gnu/arm/nt/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/gnu/microblaze/linux_toolchain/nt64_be/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/gnu/microblaze/linux_toolchain/nt64_le/bin
      export PATH=$PATH:/cygdrive/path_to/Xilinx/Vitis/202x.x/gnu/aarch32/nt/gcc-arm-none-eabi/bin

   Replace the **path_to** string with your path to the installation folder
   and the **tools version** with the proper one.


.. collapsible::  How to verify your environment setup

   Run any of the following commands. These commands will return a valid path
   if your setup is good.

   .. code-block:: bash

      [~] which git
      [~] which make
      [~] which vivado

Set up the HDL repository
-------------------------------------------------------------------------------
These designs are built upon ADI's generic HDL reference designs framework.
ADI does not distribute the bit/elf files of these projects so they
must be built from the sources available :git-hdl:`here </>`. To get
the source you must
`clone <https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository>`__
the repository. This is the best method to get the sources. Here, we are
cloning the repository inside a directory called **adi**. Please refer
to the :ref:`git_repository` section for more details.

.. code-block:: bash

   [~] mkdir adi
   [~] cd adi
   [~] git clone git@github.com:analogdevicesinc/hdl.git

.. warning::

   Cloning the HDL repository is done now using SSH, because of
   GitHub security reasons. Check out this documentation on `how to deal
   with SSH keys in
   GitHub <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>`__.
   Both for `Cygwin <https://www.cygwin.com/>`__ and
   `WSL <https://learn.microsoft.com/en-us/windows/wsl/install/>`__ it is
   necessary to create a unique SSH key. If you use WSL,to get the best
   performance, you must clone your hdl repository in the WSL file system.
   For example: (:code:`\\\\wsl.localhost\\Ubuntu\\home\\username\\hdl`)

The above command clones the **default** branch, which is the **main** for
HDL. The **main** branch always points to the latest stable release
branch, but it also has features **that are not fully tested**. If you
want to switch to any other branch you need to checkout that branch:

.. code-block:: bash

   [~] cd hdl/
   [~] git status
   [~] git checkout hdl_2022_r2

If this is your first time cloning, you have all the latest source
files. If not, you can simply pull the latest sources
using ``git pull`` or ``git rebase`` if you have local changes.

.. code-block:: bash

   [~] git fetch origin               # this shows you what changes will be pulled on your local copy
   [~] git rebase origin/hdl_2022_r2  # this updates your local copy

Set up the Testbenches repository
-------------------------------------------------------------------------------

The :git-testbenches:`` has to be cloned under the :git-hdl:`` as follows:

.. code-block:: bash

   [~] cd hdl
   [~] git clone git@github.com:analogdevicesinc/testbenches.git

The above command clones the **default** branch, which is the **main** for
Testbenches. The **main** branch always points to the latest stable release
branch, but it also has features **that are not fully tested**. If you
want to switch to any other branch you need to checkout that branch:

.. code-block:: bash

   [~] cd testbenches/
   [~] git status
   [~] git checkout 2022_r2      

Building a test bench
-------------------------------------------------------------------------------

.. caution::

   Before building any test bench, you must have the environment prepared and the
   proper tools. See `Tools`_ section on what you need to download and
   `Environment`_ section on how to set-up your environment.

The way of building a test bench in Cygwin and WSL is almost the same.
In this example, it is building the **AD7616** test bench.

.. code-block:: bash

   cd ad7616
   make

The ``make`` builds all the libraries first and then builds the test bench.
This assumes that you have the tools and licenses set up correctly. If
you don't get to the last line, the make failed to build one or more
targets: it could be a library component or the project itself. There is
nothing you can gather from the ``make`` output (other than which one
failed). The actual information about the failure is in a log file inside
the project directory.

Also, there's an option to use ``make`` using GUI, so that at the end of the
build it will launch Vivado and start the simulation.

.. code-block:: bash

   make MODE=gui

On projects which support this, some ``make`` parameters can be added, to
configure the project (you can check the **system_project.tcl** file
to see if your project supports this).

If parameters were used, the result of the build will be in a folder under runs/,
named by the configuration used.

**Example**

Running the command below will create a folder named
**cfg_si** for the following file combination: **cfg_si** configuration file and
the **test_program_si** test program.

.. code-block:: bash

   make MODE=gui CFG=cfg_si TST=test_program_si

Environment
-------------------------------------------------------------------------------

As mentioned above, our recommended build flow is to use ``make`` and the
command line version of the tools. This method facilitates our
overall build and release process as it automatically builds the
required libraries and dependencies.

Linux environment setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All major distributions should have ``make`` installed by default. If not,
if you try the command, it should tell you how to install it with the
package name.

You may have to install ``git`` (``sudo apt-get install git``)
and the AMD tools. These tools come with certain **settings*.sh** scripts that
you may source in your **.bashrc** file to set up the environment. 
You may also do this manually (for better or worse); the following snippet is
from a **.bashrc** file. Please note that unless you are an expert at manipulating
these things, it is best to leave it to the tools to set up the environment.

.. code-block:: bash

   export PATH=$PATH:/opt/Xilinx/Vivado/202x.x/bin:/opt/Xilinx/Vitis/202x.x/bin

Windows environment setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The best option on Windows is to use
`Cygwin <https://www.cygwin.com>`__. When installing it, select the
``make`` and ``git`` packages. You should do changes to your **.bashrc** in a
similar manner to the Linux environment.

.. code-block:: bash

   export PATH=$PATH:/cygdrive/d/Xilinx/Vivado/202x.x/bin:/cygdrive/d/Xilinx/Vitis/202x.x/bin

A very good alternative to Cygwin is
`WSL <https://learn.microsoft.com/en-us/windows/wsl/install/>`__. The
manual changes to your **.bashrc** should look like:

.. code-block:: bash

   export PATH=$PATH:/opt/path_to/Vivado/202x.x/bin:/opt/Vitis/202x.x/bin

If you do not want to install Cygwin, there might still be some
alternative. There are ``make`` alternatives for **Windows Command
Prompt**, minimalist GNU for Windows (**MinGW**), or the **Cygwin
variations** installed by the tools itself.

Some of these may not be fully functional with our scripts and/or projects.
If you are an AMD user, use the **gnuwin** installed as part of the SDK,
usually at ``C:\Xilinx\Vitis\202x.x\gnuwin\bin``.

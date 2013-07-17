=================================
teracy-dev - get development fun!
=================================

This ``teracy-dev`` repository was created for developing Django applications with ease and fun.
We're going to use ``virtualbox`` for running Django projects, ``chef`` and ``vagrant`` for
installing and configuring any necessary packages.

By using this approach, we can work on any host machine with different OS. We don't have to
install tons of development stuffs on the host machine to start. See FAQ section at the end of
this document for more details of OS support.

Before getting started, please see the "Frequently asked question" to know some of the common
problems you could meet and proposed solution when following "getting started" section.


Getting started
---------------

- Minimum requirement:

You're required to install ``virtualbox``, ``vagrant``.

If you're on Windows, you must install ``git`` to use ``Git Bash`` as terminal window.

Note: After installing ``vagrant`` on Windows, you need to restart your computer.

**Really Important for Windows**: You MUST ALWAYS run ``virtualbox`` and ``Git Bash`` as
**administrator** to make symlinks (of virtualenv) work as expected.

- Optional recommendation:

You should install ``git``.


1. If you're on ``Ubuntu``:

    Install ``git``, ``virtualbox``, ``vagrant`` with the provided bash script below:
    ::
        $ cd /tmp
        $ wget https://raw.github.com/teracy-official/teracy-dev/master/scripts/setup_working_env_chef.sh
        $ bash setup_working_env_chef.sh


1. Or to get started manually, you need to finish 2 required following simple steps:

    1.1. Install **latest** ``vagrant`` version at: http://downloads.vagrantup.com/

    1.2. Install ``virtualbox`` with the version of **4.2.10** at:
         https://www.virtualbox.org/wiki/Download_Old_Builds_4_2

    1.3. [Required on Windows only] Install latest ``git`` version at http://git-scm.com/ to use
    ``Git Bash`` as terminal window.

2. From home directory (``~/``), download or clone this repository and ``$ vagrant up``. You should
prepare yourself a cup of coffee as for the first time, it would take a little long time 
(~20-30 mins with internet speed ~700-800KB/s) to ``$ vagrant up``.

Note: The home directory on ``Git Bash`` normally should point to your user's directory on Windows.
For example: ``C:\Documents and Settings\<user_name>``, this is the place you will find
``teracy-dev`` directory to import projects into your Sublime Text editor.


- Have ``git`` installed: 
Open your terminal window and type:
::
    $ cd ~/
    $ git clone https://github.com/teracy-official/teracy-dev.git
    $ cd teracy-dev
    $ vagrant up

- No ``git`` installed: 
Download the repository at https://github.com/teracy-official/teracy-dev/archive/master.zip and
unzip with named ``teracy-dev`` at ``~/`` (*unix) or ``C:\Documents and Settings\<user_name>``
(Windows). Then open your terminal window:
::
    $ cd ~/
    $ cd teracy-dev
    $ vagrant up


You should see the following similar messages at the end of ``$ vagrant up``:
::
    [2013-07-01T09:57:11+00:00] INFO: Chef Run complete in 160.951322714 seconds
    [2013-07-01T09:57:11+00:00] INFO: Running report handlers
    [2013-07-01T09:57:11+00:00] INFO: Report handlers complete

Last but not least, ``$ vagrant ssh`` to access with ssh the virtual machine you have just
installed which runs Ubuntu 12.04. You should see the following similar messages:
:: 
    Welcome to Ubuntu 12.04.2 LTS (GNU/Linux 3.5.0-23-generic i686)

     * Documentation:  https://help.ubuntu.com/

    37 packages can be updated.
    18 updates are security updates.

    Last login: Wed Apr 24 07:43:49 2013 from 10.0.2.2

*Congratulations, you're all set now!*
    

``workspace`` directory
-----------------------

The ``workspace`` directory was created under ``teracy-dev``. This ``workspace`` directory is the
location where you will store all your work, after ``$ vagrant up``, the following sub directories
will be created if they do not exist yet.

``workspace/personal``: the location to store all your stuffs which you have full control of it
(your own projects).

``workspace/readonly``: the location to store all the stuffs that you could read only (open source
projects).

``workspace/teracy``: the location to store all the official stuffs of teracy's at
https://github.com/teracy-official

The ``teracy-dev/workspace`` directory from host machine was mapped to ``~/workspace`` directory
on the virtual machine. So you could access this ``workspace`` directory from the virtual machine
(``$ cd ~/workspace`` or alias ``$ ws``).

From now on, we will ``$ vagrant ssh`` and run command lines on the virtual machine if not
explicitly mentioning about running command lines on the host machine.

Start a Django project
----------------------

To start a tutorial Django project, you must run it under a virtual Python environment.
::
    $ mkvirtualenv tutorial

You should see the following similar messages:
::
    New python executable in tutorial/bin/python
    Installing setuptools............done.
    Installing pip...............done.

You're now under ``tutorial`` virtual Python environment. ``$ deactive`` to escape it or
``$ workon tutorial`` to be under ``tutorial`` virtual Python environment.
 
Let's continue to setup the ``tutorial`` project:
::
    $ ws
    $ cd personal
    $ mkdir tutorial
    $ cd tutorial
    $ git init
    $ git remote add teracy https://github.com/teracy-official/teracy.git
    $ git fetch teracy
    $ git merge teracy/master 
    $ pip install -r requirements/dev.txt
    $ ./manage.py syncdb
    $ ./manage.py runserver 0.0.0.0:8000

The project https://github.com/teracy-official/teracy.git will help us to get project development
booted with a Django project template (boilerplate) of best practices.

When ``syncdb``, you should create the super account to access the admin page.

You should see the following similar messages:
::
    Validating models...

    0 errors found
    July 01, 2013 - 10:44:01
    Django version 1.5.1, using settings 'settings.dev'
    Development server is running at http://0.0.0.0:8000/
    Quit the server with CONTROL-C.
    
Now open your browser, yes, your browser :-) with http://localhost:8000/admin and login with your
created super account.

Sweet, everything is cool now! However, the project does not do anything much yet. You need to
create Django applications for it.

Start a Django application
--------------------------

Let's open the browser at http://localhost:8000, we will see a 404 error and it's normal.

We're going to create a Django application named ``hello`` to display ``Hello World!`` message when
accessing http://localhost:8000 

It's time for coding, so we need an editor for it. ``Sublime Text`` is awesome, get and install it
now at: http://www.sublimetext.com/

Open ``Sublime Text``, add ``workspace/personal/tutorial`` project (Menu: Project -> Add Folder to
Project). The ``tutorial`` project should be opened and we could start coding now.

Usually, we need 2 terminal windows: One is used for running Django project and the other one is
used for normal commands. Just open a new terminal window, change directory to ``teracy-dev`` then
``$ vagrant ssh``.

A specific Django application should be put under ``apps`` directory. We're going to create
``hello`` application:
::
    $ ws
    $ workon tutorial
    $ cd personal/tutorial/apps
    $ ../manage.py startapp hello

Add `hello` application to ``INSTALLED_APPS`` on ``settings/dev.py`` by appending the following
configuration:
::
    INSTALLED_APPS += (
        'apps.hello',
    ) 

Create ``home.html`` template under ``apps/hello/templates/hello`` directory with following
content:
::
    {% extends 'html5boilerplate/base.html' %}

    {% block body_content %}
        <h1>Hello World!</h1>
        <h2>Welcome to <strong>teracy-dev</strong> - get development fun!</h2>
    {% endblock %}

Add ``HomeTemplateView`` to ``apps/hello/views.py``:
::
    from django.views.generic import TemplateView


    class HomeTemplateView(TemplateView):
        template_name = 'hello/home.html'

Create ``apps/hello/urls.py`` and configure ``HomeTemplateView`` with following content:
::
    from django.conf.urls import url, patterns

    from apps.hello.views import HomeTemplateView


    urlpatterns = patterns(
        '',
        url(r'^$', HomeTemplateView.as_view(), name='hello_home'),
    )

Configure the root url on ``urls/dev.py`` by adding the following content:
::
    urlpatterns += (
        url(r'', include('apps.hello.urls')),
    )  

During development, the server could be stopped by some errors and it's normal. If your coding
skill is good enough (j/k :P), the server should be still running. If not, 
``$ ./manage.py runserver 0.0.0.0:8000`` again, the server should be started without any error.

Now, open your browser at http://localhost:8000 and you should see ``Hello World!`` page instead
of the 404 error page.


Congratulations, you've just created a Django application and make it work even though it does
nothing other than "Hello World!" page. You should now learn Django by developing many more
applications for this ``tutorial`` project by adapting Django tutorials at
https://docs.djangoproject.com/en/1.5/.


Join and work with us?
----------------------

We are starting up and have tons of interesting projects waiting for you. We need you - young
developers, having passion to learn and to work with us in a smart way. What you need to
do is to simply ``impress us``.

How to impress us?

- Show your passion to learn and work with us

- Show your interest with our development model

- Join and discuss with us about anything, yes anything :)
    + Facebook group: https://www.facebook.com/groups/teracy/
    + Google group: https://groups.google.com/forum/#!forum/teracy

- Contribute to our public projects at: https://github.com/teracy-official/teracy-dev

When you impress us enough, wherever you are, we will find you and offer you the job you
desire!

Learn more
----------

- Teracy's projects

    + https://github.com/teracy-official/teracy

    + https://github.com/teracy-official/teracy-html5boilerplate

- Vagrant

    + http://www.vagrantup.com/

- Sublime Text
    
    + http://www.sublimetext.com/

- Django

    + https://docs.djangoproject.com/en/1.5/

    + http://www.djangobook.com/en/2.0/index.html

    + http://www.deploydjango.com/

    + ``pip``: http://www.pip-installer.org/en/latest/

    + ``virtualenv``: http://www.virtualenv.org/en/latest/

    + ``virtualenvwrapper``: http://virtualenvwrapper.readthedocs.org/en/latest/

- Python
    
    + http://python.org/doc/

    + http://www.diveintopython.net/

    + http://learnpythonthehardway.org/book/

- Git
    
    + http://git-scm.com/book

- Vim
    
    + http://www.openvim.com/tutorial.html

    + https://www.shortcutfoo.com/app/tutorial/vim

- Linux 
    
    + http://www.quora.com/Linux/What-are-the-good-online-resources-for-a-linux-newbie

    + http://www.quora.com/Linux/What-are-some-time-saving-tips-that-every-Linux-user-should-know

    + http://kernelnewbies.org/


Installed packages on the virtual machine
-----------------------------------------

The base box is provided by https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04-i386_chef-11.4.4.box 
and additional packages installed are:

- ``apt``.

- ``vim`` as ``EDITOR`` environment.

- ``git``.

- ``Python`` with ``pip``, ``virtualenv`` and ``virtualenvwrapper``.

- ``libpq-dev``, ``python-dev``

- ``tree``

- aliases:

    + ``ws`` => ``cd ~/workspace``

You could see it clearly on ``Vagrantfile`` with the following similar content:
::
      # Enable provisioning with chef solo, specifying a cookbooks path, roles
      # path, and data_bags path (all relative to this Vagrantfile), and adding
      # some recipes and/or roles.
      #
      config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.roles_path = "roles"
        chef.data_bags_path = "data_bags"

        chef.add_recipe "apt" #required for installing vim (?!)
        chef.add_recipe "vim"
        chef.add_recipe "python"
        chef.add_recipe "git"
        chef.add_recipe "teracy-dev"
      #   chef.add_recipe "mysql"
      #   chef.add_role "web"
      #
      #   # You may also specify custom JSON attributes:
      #   chef.json = { :mysql_password => "foo" }
      end

For more information about ``chef``, see it at http://www.opscode.com/chef/.


Frequently asked questions
--------------------------

1. **My internet speed is slow, ``$ vagrant up`` takes long time and comes back to 0% after reach
more than 50%?**

For slow internet connection (~200KB/s or lower), you could use a download accelerator to
download .box file (400-500MB) first with the link:
https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04-i386_chef-11.4.4.box

And before ``$ vagrant up``, you must execute the command below:
::
    $ vagrant box add opscode-ubuntu-1204 path_to_the_downloaded_file.box

If you're on Windows and downloaded the ``.box`` file to your ``Desktop`` and:
::
    $ vagrant box add opscode-ubuntu-1204 ~/Desktop/opscode_ubuntu-12.04-i386_chef-11.4.4.box

The output could be something similar like this:
::
    Downloading or copying the box...
    Extracting box...te: 66.3M/s, Estimated time remaining: 0:00:01)
    Successfully added box 'opscode-ubuntu-1204' with provider 'virtualbox'!

2. **What OS should I use for best development environment?**

You could use any OS to start development (Windows XP, Windows 7, Windows 8, Mac,
Ubuntu, etc.)

However, Windows is NOT recommended for best development experience. It's better to work on any
*nix compatible OS (Mac OSX, Ubuntu, Fedora, Redhat, etc.).

Ubuntu 12.04 is a **strongly** recommended OS for development, get it now at:
http://www.ubuntu.com/download/desktop

3. **After ``$ vagrant up``, there is an error saying that ``virtualbox`` has error, can't run and
quit?**

Make sure you install the exact version **4.2.10** of ``virtualbox``.

4. **How could I update ``teracy-dev``?**

We're trying to make the update as painless as possible so that we don't have to ``detroy`` and
``up`` again as it is time consuming. We try to make the update with ``provision``, acceptable
``reload``. If we have to ``destroy`` and ``up`` again, it will be the next major release version.

- Have ``git`` installed:

Follow these commands below:
::
    $ git fetch origin
    $ git merge origin/master

- No ``git`` installed:

    + You need to move all your work under ``home`` and ``workspace`` directory to outside of
    ``teracy-dev``

    + Delete ``teracy-dev``
    
    + Download the repository at https://github.com/teracy-official/teracy-dev/archive/master.zip and
    unzip with named ``teracy-dev`` at ``~/`` (*unix) or ``C:\Documents and Settings\<user_name>``
    (Windows).
    
    + Move all your work under ``home`` and ``workspace`` back to ``teracy-dev`` and start working
    as normal.

5. **How to use ssh keys on the virtual machine**?

``teracy-dev/home/.ssh`` on the host machine and ``~/.ssh`` on the virtual machine are in sync. You
could copy your existing ssh keys into one location and it will be available in the other location.

5.1. It's easier to use the host machine to forward ssh access. Just enable it on ``Vagrantfile``
::
    config.ssh.forward_agent = true

It seems that Windows is having problem with ``forward_agent``, Windows users should move to 5.2.

5.2. Or to use existing ssh keys, type the following commands on the host machine
terminal window:
::
    $ cd teracy-dev
    $ cp ~/.ssh/id_rsa* home/.ssh

5.3. Or to create new ssh keys on the virtual machine, just create it and these keys will be copied
into ``teracy-dev/home/.ssh``.
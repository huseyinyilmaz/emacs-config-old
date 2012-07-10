Installation
------------

At your home directory run

    git clone git://github.com/huseyinyilmaz/emacs-config.git .emacs.d # clone repo
    cd .emacs.d # get into the newly downloaded repo
    git submodule init # initilize dependency submodules
    git submodule update # update submodules

After that install dependencies

    sudo pip install -r plugins/flymake-python/requirements.pip # install python validation tools.

    apt-get install sbcl # cl

    cd .. # goto home directory you could also just write (cd[enter-key])
    ln -s .emacs.d/dot_emacs.el .emacs.el # create a symbolic link

Installation
------------

At your home directory run

    git clone git://github.com/huseyinyilmaz/emacs-config.git .emacs.d # clone repo
    cd .emacs.d # get into the newly downloaded repo
    git submodule init # initilize dependency submodules
    git submodule update # update submodules

After that install dependencies

    sudo pip install -r plugins/flymake-python/requirements.pip # install python validation tools.

    # This dependency is for common lisp. if you don't need common lisp support skip the rest

    TODO quicklisp and slime-helper installation
    
    apt-get install sbcl # cl


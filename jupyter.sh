#! /usr/bin/bash

# enable ipywidgets
jupyter labextension install @jupyter-widgets/jupyterlab-manager

# add table of contents
jupyter labextension install @jupyterlab/toc

# variableInspector: https://github.com/lckr/jupyterlab-variableInspector
jupyter labextension install @lckr/jupyterlab_variableinspector

# jupyter unoffical extensions
conda install -c conda-forge jupyter_contrib_nbextensions

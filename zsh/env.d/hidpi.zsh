#!/usr/bin/env zsh

# Variables to scale GUI elements in HiPDI screens
export _SCALE_FACTOR_=2

# Qt5
# export QT_AUTO_SCREEN_SCALE_FACTOR=$_SCALE_FACTOR_
export QT_SCALE_FACTOR=$_SCALE_FACTOR_

# GDK 3 (GTK+ 3)
export GDK_SCALE=$_SCALE_FACTOR_

# Elementary (EFL)
export ELM_SCALE=$_SCALE_FACTOR_

# vim:set ft=zsh:

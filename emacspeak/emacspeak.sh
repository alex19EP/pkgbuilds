#!/bin/sh
export DTK_PROGRAM=espeak
emacs -l /usr/share/emacs/site-lisp/emacspeak/lisp/emacspeak-setup.el "$@"

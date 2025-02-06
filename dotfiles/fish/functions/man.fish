# Copy of `man.fish` definition found on NixOS with added color definition
function man --description 'Format and display the on-line manual pages'
    # Work around the "builtin" manpage that everything symlinks to,
    # by prepending our fish datadir to man. This also ensures that man gives fish's
    # man pages priority, without having to put fish's bin directories first in $PATH.

    # Preserve the existing MANPATH, and default to the system path (the empty string).
    set -l manpath
    if set -q MANPATH
        set manpath $MANPATH
    else if set -l p (command man -p 2>/dev/null)
        # NetBSD's man uses "-p" to print the path.
        # FreeBSD's man also has a "-p" option, but that requires an argument.
        # Other mans (men?) don't seem to have it.
        #
        # Unfortunately NetBSD prints things like "/usr/share/man/man1",
        # while not allowing them as $MANPATH components.
        # What it needs is just "/usr/share/man".
        #
        # So we strip the last component.
        # This leaves a few wrong directories, but that should be harmless.
        set manpath (string replace -r '[^/]+$' '' $p)
    else
        set manpath ''
    end
    # Notice the shadowing local exported copy of the variable.
    set -lx MANPATH $manpath

    # Prepend fish's man directory if available.
    set -l fish_manpath $__fish_data_dir/man
    if test -d $fish_manpath
        set MANPATH $fish_manpath $MANPATH
    end

    if test (count $argv) -eq 1
        # Some of these don't have their own page,
        # and adding one would be awkward given that the filename
        # isn't guaranteed to be allowed.
        # So we override them with the good name.
        switch $argv
            case :
                set argv true
            case '['
                set argv test
            case .
                set argv source
        end
    end

	## set man colors
	#
	# tput colors:
	#   0:black,  1:red,      2:green,   3:yellow
	#   4:blue,   5:magenta,  6:cyan,   7:white
	#
	# mb: blink
	set -x LESS_TERMCAP_mb $(tput bold; tput setaf 2) # green
	# me: end all modes
	set -x LESS_TERMCAP_me $(tput sgr0)
	# md: bold
	set -x LESS_TERMCAP_md $(tput bold; tput setaf 2) # green
	# so/se: stand-out/reverse
	set -x LESS_TERMCAP_so $(tput bold; tput setaf 3; tput setab 4) # yellow on blue
	set -x LESS_TERMCAP_se $(tput rmso; tput sgr0)
	# us/ue: underline
	set -x LESS_TERMCAP_us $(tput smul; tput bold; tput setaf 6) # cyan
	set -x LESS_TERMCAP_ue $(tput rmul; tput sgr0)
	# reverse, dim, others...
	set -x LESS_TERMCAP_mr $(tput rev)
	set -x LESS_TERMCAP_mh $(tput dim)
	set -x LESS_TERMCAP_ZN $(tput ssubm)
	set -x LESS_TERMCAP_ZV $(tput rsubm)
	set -x LESS_TERMCAP_ZO $(tput ssupm)
	set -x LESS_TERMCAP_ZW $(tput rsupm)
	set -x GROFF_NO_SGR 1         # For Konsole and Gnome-terminal

    command man $argv
end

#!/bin/sh
# Keep the machine-wide Node toolchain deterministic without selecting an NVM runtime.

if [ "${PATH+x}" = x ]; then
    _node_toolchain_path_was_set=1
else
    _node_toolchain_path_was_set=0
fi

_node_toolchain_rest=${PATH-}
_node_toolchain_new=
_node_toolchain_new_is_set=0

while :; do
    case $_node_toolchain_rest in
        *:*)
            _node_toolchain_entry=${_node_toolchain_rest%%:*}
            _node_toolchain_rest=${_node_toolchain_rest#*:}
            _node_toolchain_has_separator=1
            ;;
        *)
            _node_toolchain_entry=$_node_toolchain_rest
            _node_toolchain_rest=
            _node_toolchain_has_separator=0
            ;;
    esac

    case $_node_toolchain_entry in
        /opt/homebrew/bin|/opt/homebrew/sbin)
            ;;
        *)
            if [ "$_node_toolchain_new_is_set" = 0 ]; then
                _node_toolchain_new=$_node_toolchain_entry
                _node_toolchain_new_is_set=1
            else
                _node_toolchain_new=$_node_toolchain_new:$_node_toolchain_entry
            fi
            ;;
    esac

    [ "$_node_toolchain_has_separator" = 1 ] || break
done

if [ "$_node_toolchain_path_was_set" = 1 ] && [ "$_node_toolchain_new_is_set" = 1 ]; then
    PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$_node_toolchain_new
else
    PATH=/opt/homebrew/bin:/opt/homebrew/sbin
fi
export PATH

unset _node_toolchain_path_was_set _node_toolchain_rest _node_toolchain_new
unset _node_toolchain_new_is_set _node_toolchain_entry _node_toolchain_has_separator

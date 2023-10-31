import sys
from pathlib import Path
from bb_parser import *

import scripts
import links
import deps
import utils

action_map = [("deps", deps.install_deps),
              ("links", links.install_links),
              ("scripts", scripts.run_scripts)]

def install_dispatch(args):
    if "action" in args:
        args["action"](args)
    else:
        for (_, action) in action_map:
            action(args)

def get_cli_parser():
    help_flag = Flag(Enum("-h", "--help"), key="help")

    target = ExistingPath(key="target")
    create_flag = Flag(FirstOf(Exact("-c"), Exact("--create")), key="create")
    manage = Exact("manage", key="cmd", value=links.manage_link) + String(key="component") + create_flag + target

    unmanage = Exact("unmanage", key="cmd", value=links.unmanage_link) + target

    action  = Enum([x[0] for x in action_map], key="action", values=[x[1] for x in action_map])
    install = Exact("install", key="cmd", value=install_dispatch) + String(key="component") + Optional(action + Optional(Integer(key="index")))

    return help_flag + Optional(FirstOf(manage, unmanage, install)) + EndOfInput()

def main():
    try:
        args = get_cli_parser().parse(sys.argv[1:])

        if args["help"] or "cmd" not in args:
            help_msg("")
            sys.exit(1)

        args["cmd"](args)
    except ParseError as err:
        print("Failed to parse command line")
        help_msg("")
        sys.exit(1)


def help_msg(args):
    help_str = """usage: dotfiles [-h|--help] command args

command and args:
    manage <component> [-c | --create] <file | folder>
    unmanage <file|folder>
    install <component> [<deps | links | scripts> [index]]
"""
    print(help_str)


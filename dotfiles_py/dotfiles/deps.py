from pathlib import Path
import tempfile
from .component import Component
from . import utils


def install_deps(args):
    def get_first_element(dictionary):
        return list(dictionary.items())[0]

    def install_pacman_deps(deps):
        utils.run_cmd(f"sudo pacman --noconfirm -S {' '.join(deps)}")

    def install_pipx_deps(deps):
        utils.run_cmd(f"pipx install {' '.join(deps)}")

    def install_yay_deps(deps):
        utils.run_cmd(f"yay --noconfirm -S  {' '.join(deps)}")

    def install_aur_deps(deps):
        for deps_dict in deps:
            dep_name, dep = get_first_element(deps_dict)
            with tempfile.TemporaryDirectory() as temp_dir:
                cwd = Path(temp_dir)
                utils.run_cmd(f"git clone {dep} {dep_name}", str(cwd))
                cwd = cwd / dep_name
                utils.run_cmd(f"makepkg -is --noconfirm", str(cwd))

    db = Component(args["component"]).read_db()

    if "deps" not in db:
        print("Skip install dependencies, no dependencies are managed for this component.")
        return
    dispatch = {"pacman": install_pacman_deps,
                "pipx": install_pipx_deps,
                "yay": install_yay_deps,
                "aur": install_aur_deps}
    if "index" in args:
        deps_type, deps = get_first_element(db["deps"][args["index"]])
        dispatch[deps_type](deps)
    else:
        for deps_item in db["deps"]:
            deps_type, deps = get_first_element(deps_item)
            try:
                dispatch[deps_type](deps)
            except KeyError:
                print(f"Skip dependencies for {deps_type}, this type is not supported")

import shutil
import os
from pathlib import Path
from component import Component, component_iter


def manage_link(args):
    target = args["target"]
    if target.is_symlink():
        raise RuntimeError(f"target {target} is a symlink and cannot be managed")

    component = Component(args["component"], args["create"])
    db = component.read_db()

    shutil.move(str(target), component.get_dir())

    link_info = {"name": target.name, "dest": str(target)}
    _set_soft_link(link_info, component.get_dir())

    if "links" not in db:
        db["links"] = []
    db["links"].append(link_info)

    component.write_db(db)


def unmanage_link(args):
    def remove_link_if_in_db(component, target):
        db = component.read_db()
        if "links" not in db:
            return False
        for managed_obj in db["links"]:
            if Path(managed_obj["dest"]) == target:
                db["links"].remove(managed_obj)
                component.write_db(db)
                return True
        return False

    target = args["target"]
    if not target.is_symlink():
        raise RuntimeError(f"target {target} is a not symlink")

    target_physical = target.readlink()
    for component in component_iter():
        if remove_link_if_in_db(component, target):
            target.unlink()
            shutil.move(target_physical, target)
            return

    raise RuntimeError(f"target {target} is not managed by dotfiles")


def install_links(args):
    component = Component(args["component"])
    db = component.read_db()

    if "links" not in db:
        print("Skip install links, no links are managed for this component.")
        return
    if "index" in args:
        link_info = db["links"][args["index"]]
        _set_soft_link(link_info, component.get_dir())
    else:
        for link_info in db["links"]:
            _set_soft_link(link_info, component.get_dir())


def _set_soft_link(link_info, component_dir):
    dest = Path(os.path.expanduser(link_info["dest"]))
    dest.parent.mkdir(parents=True, exist_ok=True)
    if dest.exists():
        print(f"Skip install link for {dest} because file exists")
    else:
        dest.symlink_to(component_dir / link_info["name"])

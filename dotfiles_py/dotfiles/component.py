from subprocess import Popen, PIPE
import json
import os
from pathlib import Path

DB_NAME = "db.json"
DOTFILES_ROOT = Path(os.environ.get("DOTFILES_ROOT"))


class Component:
    def __init__(self, component_str, create=False):
        self.component_str = component_str

        if create:
            os.makedirs(str(self.get_dir()))
            self.write_db(dict())

    def read_db(self):
        with self._get_db_path().open() as fd:
            return json.load(fd)

    def write_db(self, data):
        with self._get_db_path().open(mode="w") as fd:
            json.dump(data, fd, sort_keys=True, indent=4)

    def get_dir(self):
        return DOTFILES_ROOT / self.component_str

    def _get_db_path(self):
        return self.get_dir() / DB_NAME

def component_iter():
    for json_db_path in DOTFILES_ROOT.rglob(f"**/{DB_NAME}"):
        yield Component(json_db_path.parent.relative_to(DOTFILES_ROOT))

import utils
from component import Component


def run_scripts(args):
    component = Component(args["component"])
    db = component.read_db()

    if "scripts" not in db:
        print("Skip install scripts, no scripts are managed for this component.")
        return
    if "index" in args:
        utils.run_cmd(db['scripts'][args['index']], cwd=str(component.get_dir()))
    else:
        for script in db["scripts"]:
            utils.run_cmd(script, cwd=str(component.get_dir()))

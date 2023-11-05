from subprocess import Popen, PIPE
import sys


def run_cmd(cmd, cwd=None):
    print(f"### Run command: {cmd}")
    with Popen(cmd, stdin=PIPE, stdout=sys.stdout, stderr=sys.stderr, cwd=cwd, shell=True) as process:
        process.communicate()
        if process.returncode != 0:
            raise RuntimeError(f"cmd {cmd} failed with return code {process.returncode}")

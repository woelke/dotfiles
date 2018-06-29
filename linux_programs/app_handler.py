#!/usr/bin/python3
import sys, getopt, json, os, subprocess
from abc import ABC, abstractmethod

program_list_file ="program_list.json"

class program_db:
    def __init__(self, file):
        self.reset(file)

    def reset(self, file):
        self.data = json.load(open(file, mode="r"))

    def groups(self):
        return self.data.keys()

    def items(self, group_filter=[], source_filter=[]):
        for group in self.groups():
            if not group_filter or group in group_filter:
                for name, (source, comment) in self.data[group].items():
                    if not source_filter or source in source_filter:
                        yield (name, source, comment)

    def sources(self, group_filter=[]):
        found_sources = []
        for name, source, comment in self.items(group_filter):
            if source not in found_sources:
                found_sources.append(source)
                yield source 

class source(ABC):
    def __init__(self, source_name):
        self.source_name = source_name

    def __str__(self):
        return "source: " + self.source_name

    @abstractmethod
    def install(self, names):
        pass

    @abstractmethod
    def remove(self, names):
        pass

    @abstractmethod
    def validate(self, names):
        pass

class apt(source):
    def __init__(self):
        source.__init__(self, "apt")

    def available_names(self):
        if hasattr(self, "_apt__available_names"):
            return self.__available_names
        result = set()
        cmd = "apt-cache"
        arg = "dumpavail"
        output = subprocess.Popen([cmd, arg], stdout=subprocess.PIPE).communicate()[0]
        str_list = str(output).split("\\n")
        for i in str_list:
            tmp = i.split(" ")
            if(tmp[0]== "Package:"):
                result.add(tmp[1])
        self.__available_names = result
        return self.__available_names

    def install(self, names):
        cmd = "sudo apt -y install "
        if names:
            os.system(cmd + " ".join(names))

    def remove(self, names):
        cmd = "sudo apt -y remove "
        if names:
            os.system(cmd + " ".join(names))

    def validate(self, names):
        valid = []
        invalid = []
        for name in names:
            if name in self.available_names():
                valid.append(name)
            else:
                invalid.append(name)
        return (valid, invalid)

class validation_statistics:
    def __init__(self):
        self.used_sources = set()
        self.source_handlers = set()
        self.valid_items = []
        self.invalid_items = []
        self.items_without_handler = []

    def missing_source_handlers(self):
        return set(self.used_sources) - set(self.source_handlers)

    def duplicate_valid_items(self):
        seen = set()
        duplicates = set()
        for item in self.valid_items:
            if item in seen:
                duplicates.add(item)
            else:
                seen.add(item)
        return duplicates 

    def add(self, stat):
        self.used_sources = set(self.used_sources) | set(stat.used_sources)
        self.source_handlers = set(self.source_handlers) | set(stat.source_handlers)
        self.valid_items = self.valid_items + list(stat.valid_items)
        self.invalid_items = self.invalid_items + list(stat.invalid_items)
        self.items_without_handler = self.items_without_handler + list(stat.items_without_handler)

    def print(self, group="all"):
        print("# group: " + str(group))
        print("  - available source handlers: " + ", ".join(self.source_handlers))
        print("  - missing source handlers: " + ", ".join(self.missing_source_handlers()))
        print("  - valid items: " + ", ".join(self.valid_items))
        print("  - invalid items: " + ", ".join(self.invalid_items))
        print("  - items without handler: " + ", ".join(self.items_without_handler))
        print("  - duplicate items: " + ", ".join(self.duplicate_valid_items()))

class user_handler():
    def help():
        w=26
        print ("allowed parameters are:")
        print ("\t[-h | --help]")
        print ("\t[-f | --file]".ljust(w) + "Select file list (default: program_list.json)")
        print ("\t[-i | --install (X|all)]".ljust(w) + "Intall programm of group X")
        print ("\t[-r | --remove X]".ljust(w) + "Remove programms of group X")
        print ("\t[-l | --list]".ljust(w) + "List all groups")
        print ("\t[--items X]".ljust(w) + "List all elements of group X")
        print ("\t[-c | --check (X|all)]".ljust(w) + "Compare program list with source repositories")

    def groups(db):
        for i in db.groups():
            print(i)

    def items(db, group):
            w=16
            for name, source, comment in db.items(group_filter=[group]):
                print(name[:w].ljust(w, " ") + " - (" + source + ") " + comment)

    def validate(db, source_handlers, group):
        def validate_group(db, source_handlers, group):
            # validate sources
            stat = validation_statistics()
            stat.used_sources = db.sources(group_filter=[group]);
            stat.source_handlers = source_handlers.keys()
            # validate names
            for source_name, source_handler in source_handlers.items():
                names = [item[0] for item in db.items(group_filter=[group], source_filter=[source_name])]
                valid, invalid = source_handler.validate(names)
                stat.valid_items = stat.valid_items + valid
                stat.invalid_items = stat.invalid_items + invalid
            if len(stat.missing_source_handlers()) > 0:
                stat.items_without_handler = [item[0] for item in db.items(group_filter=[group], source_filter=list(stat.missing_source_handlers))]
            return stat
        if group != "all":
            validate_group(db, source_handlers, group).print(group)
        else:
            result = validation_statistics();
            for group in db.groups():
                result.add(validate_group(db, source_handlers, group))
            result.print(group)

    def for_each_source_handler(source_handlers, db, group, fun):
        if group != "all":
            for source_name, source_handler in source_handlers.items():
                names = [items[0] for item in db.items(group_filter=[group], source_filter=[source_name])]
                fun(source_handler, names)
        else:
            for source_name, source_handler in source_handlers.items():
                names = [item[0] for item in db.items(source_filter=[source_name])]
                fun(source_handler, names)

def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hf:i:r:lc:",["help", "file=", "install=", "remove=", "list", "items=", "check="])
    except getopt.GetoptError:
        user_handler.help()
        sys.exit(1)
    db = program_db(program_list_file)
    source_handlers = {"apt": apt()}
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            user_handler.help()
        if opt in ("-f", "--file"):
            db.reset(arg)
        elif opt in ("-i", "--install"):
            def install_fun(source_handler, names):
                source_handler.install(names)
            user_handler.for_each_source_handler(source_handlers, db, arg, install_fun)
        elif opt in ("-r", "--remove"):
            def remove_fun(source_handler, names):
                source_handler.remove(names)
            user_handler.for_each_source_handler(source_handlers, db, arg, remove_fun)
        elif opt in ("-l", "--list"):
            user_handler.groups(db)
        elif opt in ("-c", "--check"):
            user_handler.validate(db, source_handlers, arg)
        elif opt in ("--items"):
            user_handler.items(db, arg)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        main(sys.argv[1:])
    else:
        user_handler.help()


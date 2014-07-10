#!/usr/bin/python
import sys, getopt, json, os, subprocess

def get_file_name():
    return "program_list.json"

def get_json_data():
    return json.load(open(get_file_name(), mode="r", encoding="utf-8")) 

def get_programm_groups():
    return sorted(get_json_data().keys())
   

def get_group_items(group):
    if group in get_json_data(): 
        return get_json_data()[group]
    else:
        return [] 

def install_programms(group):
    def install(group):    
        install_cmd = "sudo apt-get -y install "
        for g in get_group_items(group):
            os.system(install_cmd + g)

    if group == "all":
        for i in get_programm_groups():
            install(i)
    else:
        install(group)    

def remove_programms(group):
    install_cmd = "sudo apt-get -y remove "
    for g in get_group_items(group):
        os.system(install_cmd + g)

def check_programms(group):
    def get_repro_set():
        result_set = set()
        install_cmd = "apt-cache"
        argument = "dumpavail"
        output = subprocess.Popen([install_cmd, argument], stdout=subprocess.PIPE).communicate()[0]
        str_list = str(output, encoding='utf8').split("\n")
        for i in str_list:
            tmp = i.split(" ")
            if(tmp[0]== "Package:"):
                result_set.add(tmp[1])    
        return result_set 

    def check(group, repro_set):    
        unkown_list = []
        for g in get_group_items(group):
            if g in repro_set:
                print (g + ": OK!")
            else:
                unkown_list.append(g)
        return unkown_list  

    repro_set = get_repro_set()
    unkown_list = []
    if group == "all":
        for i in get_programm_groups():
            unkown_list.extend(check(i,repro_set))
    else:
        unkown_list = check(group,repro_set)    

    for i in unkown_list:
        print (i + ": NOT FOUND!!!")  

    if len(unkown_list) > 0:
        sys.exit(1) 


def help():
    w=26
    print ("allowed parameters are:")
    print ("\t[-h | --help]") 
    print ("\t[-i | --install (X|all)]".ljust(w) + "intall programm of group X")
    print ("\t[-r | --remove X]".ljust(w) + "remove group of programms X")  
    print ("\t[-l | --list]".ljust(w) + "list all groups")
    print ("\t[--items X]".ljust(w) + "list all elements of group X")
    print ("\t[-c | --check (X|all)]".ljust(w) + "compare programms with the repository")

def list(group):
    if(group == ""):
        for i in get_programm_groups():
            print (i)
    else:
        w=16
        for i in get_group_items(group):
            print (i[:w].ljust(w, " ") + " - " + get_group_items(group)[i])

def main(argv):
    try:
        opts, args = getopt.getopt(argv,"hi:r:lc:",["help", "install=", "remove=", "list", "items=", "check="])
    except getopt.GetoptError:
        help()
        sys.exit(1)

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            help()
        elif opt in ("-i", "--install"):
            install_programms(arg)
        elif opt in ("-r", "--remove"):
            remove_programms(arg)
        elif opt in ("-l", "--list"):
            list("")
        elif opt in ("-c", "--check"):
            check_programms(arg)
        elif opt in ("--items"):
            list(arg)

if __name__ == "__main__":
    main(sys.argv[1:])

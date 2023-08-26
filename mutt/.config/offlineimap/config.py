from subprocess import check_output

def get_user(pass_id):
    p = check_output(("bwu", "get", "username", pass_id))
    return p

def get_pass(pass_id):
    p = check_output(("bwu", "get", "password", pass_id))
    return p

from flask import session,redirect,url_for,render_template
from functools import wraps

def func_check_login(func):
    @wraps(func)
    def inner(*arg,**kwargs):
        if session.get('username') is not None:
            return func(*arg,**kwargs)
        else:
            return render_template("index.html")
    return inner
import sys,os,time
import hashlib

class tomd5(object):
    def __new__(self,password):
        md5 = hashlib.md5()
        md5.update(password.encode())
        return md5.hexdigest()

class SerializationObject(object):
    def to_dict(self):
        value = {}
        for i in object:
            i 

        return value
#!/usr/bin/python

import urllib2
import json
import bluetooth
import time

print "In/Out Board"

host = '192.168.8.197:4000'
# host = '192.168.8.222'

person_dictonary = {
    "Dave": "74:B5:87:33:33:33,
    "Amy": "24:F0:94:33:33:33",
    # "Emily": "",
    # "Ben": "",
    "Adam": "08:74:02:6F:33:33:33"
    # "Laura": "",
    # "Afton": ""
}

def send_status_to_server(name, status):
    data = {'name': name, 'status': status}
    url = "http://" + host + "/api/v1/statuses"

    req = urllib2.Request(url)
    req.add_header('Content-Type', 'application/json')
    response = urllib2.urlopen(req, json.dumps(data))

while True:
    print "Checking " + time.strftime("%a, %d %b %Y %H:%M:%S", time.gmtime())

    for key, value in person_dictonary.items():
        result = bluetooth.lookup_name(value, timeout=5)
        if (result != None):
            print("%(key)s: In" % locals())
            send_status_to_server(key, 'In')
        else:
            print("%(key)s: Out" % locals())
            send_status_to_server(key, 'Out')

    time.sleep(60)


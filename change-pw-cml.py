#!/bin/python3
import json
import requests
import sys
import warnings
warnings.resetwarnings()

warnings.filterwarnings('ignore')

URL_HEAD = sys.argv[1]
OLD_PW = sys.argv[2]
NEW_PW = sys.argv[3]
bearer = requests.post('{}/api/v0/authenticate'.format(URL_HEAD),
                       headers={"accept": "application/json",
                                "Content-Type": "application/json"},
                       data=json.dumps({"username": "admin",
                                        "password": OLD_PW}), verify=False)
print(bearer.text)
bearer_output = str(bearer.text).replace('''"''',"")
get_uuid = requests.get("{}/api/v0/users/admin/id".format(URL_HEAD),
                        headers={"Authorization": "Bearer {}".format(bearer_output)}, verify=False)
uuid_of_user = get_uuid.text.replace('''"''',"")
print(repr(uuid_of_user))
print('{}/api/v0/users/{}'.format(URL_HEAD,uuid_of_user))
changepw = requests.patch(r'{}/api/v0/users/{}'.format(URL_HEAD,uuid_of_user.replace("\n","")),
                       headers={"accept": "application/json",
                                "Content-Type": "application/json", "Authorization": "Bearer {}".format(bearer_output)},
                       data=json.dumps({"password": {"old_password": OLD_PW, "new_password": NEW_PW}}), verify=False)
print(changepw.text)
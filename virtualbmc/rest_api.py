import requests
import logging

class Api(object):
    def __init__(self, host = "http://localhost", api_key=None, api_key_prefix = 'Bearer ', ssl_ca_cert = None,log_dest = 'api.log'):
        if api_key is None:
            self.headers_content = {}
        else:
            self.headers_content = {'Content-Type':'application/json',
               'Authorization': 'Bearer {}'.format(api_key)}
        self.host = host
        self.ssl_ca_cert = ssl_ca_cert
        logging.basicConfig(filename=log_dest,level=logging.DEBUG)
        
    
    def vm_action(self, namespace, name, action):
        url = f"/apis/subresources.kubevirt.io/v1alpha3/namespaces/{namespace}/virtualmachines/{name}/{action}"
        r = requests.put(self.host + url, headers=self.headers_content, verify=self.ssl_ca_cert)
        logging.debug(r.headers)

    def vm_status(self, namespace, name):
        url = f"/apis/kubevirt.io/v1alpha3/namespaces/{namespace}/virtualmachines/{name}/"
        r = requests.get(self.host + url, headers=self.headers_content, verify=self.ssl_ca_cert)
        return r.json()

    def test(self,url):
        response = requests.get(self.host + url, headers=self.headers, verify=self.ssl_ca_cert)
        print(response.content)
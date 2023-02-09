#!/usr/bin/python
''' Make me a module
'''

from xml.dom import minidom
import json,re

class jsonwalker:
    
    def __init__(self):
        pass

    def makedoc(self,xmlstring):
        #xmlstring = re.sub("(?ms)^<\?[^>]*\?>","",xmlstring);
        dom = minidom.parseString(xmlstring)
        return dom.documentElement

    def walktojson(self, elem):
        obj = {}
        obj["children"] = []
        if len(elem.childNodes) == 0 and elem.nodeName == "term":
            obj["children"] = [""]
        for child in elem.childNodes:
            if child.nodeName == "#comment":
                pass
            elif child.nodeName == "#text":
                if len(elem.childNodes) == 1 and elem.nodeName in ["term","single","multiple"]:
                    obj["children"].append(child.wholeText)
            else:
                obj["children"].append(self.walktojson(child))

        obj["name"] = elem.nodeName

        obj["attrs"] = {}
        if elem.attributes:
            for key in elem.attributes.keys():
                obj["attrs"][key] = elem.attributes[key].value

        return obj

if __name__ == "__main__":

    import sys
    w = jsonwalker()
    doc = w.makedoc(open(sys.argv[1]).read())
    obj = w.walktojson(doc)
    print(json.dumps(obj))

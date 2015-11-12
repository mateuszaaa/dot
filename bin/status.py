#!/usr/bin/python3
from xml.dom import minidom
from urllib.request import FancyURLopener
import sys

class Parser:
    ELEMENT_TYPE = 1
    hashes = {}
    current_hash = None

    def __init__(self, html_content, url):
        self.doc = minidom.parseString(html_content)
        self.url = url

    def process_node(self, current_node):
        self.analyze_node(current_node)
        for node in current_node.childNodes:
            self.process_node(node)

    def analyze_node(self, node):

        if self.is_element_node(node):
            self.parseCommimtHash(node)
            self.parse_html_report_paths(node)

    def parse_html_report_paths(self, node):
        hrefs = node.getElementsByTagName('a')
        for i in hrefs:
            self.save_html_report_path(i)

    def save_html_report_path(self, i):
        if self.contains_info_about_build_status_url(i):
            if self.current_hash is not None:
                report_relative_path = self.get_relative_path_to_build_report(i)
                self.hashes[self.current_hash].append(report_relative_path)

    def get_relative_path_to_build_report(self, i):
        return i.getAttribute('href')

    def contains_info_about_build_status_url(self, i):
        return i.hasAttribute('href')

    def parseCommimtHash(self, node):
        if self.contain_info_about_hash(node):
            self.current_hash = self.parseCommitHash(node)
            self.hashes[self.current_hash] = []

    def parseCommitHash(self, node):
        return node.firstChild.nodeValue.strip().split(' ')[0][:-3]

    def contain_info_about_hash(self, node):
        return node.getAttribute('class') == 'sourcestamp'

    def is_element_node(self, node):
        return node.nodeType == self.ELEMENT_TYPE;

    def start(self):
        elements = self.doc.getElementsByTagName('td')
        for i in elements:
            self.process_node(i)

    def showResults(self):
        for commit in self.hashes:
            print(commit)
            print(self.hashes[commit])

    def report(self, hash):
        norm_hash = self.normalizeHash(hash)
        for h in self.hashes.keys():
            if norm_hash in h:
                for i in self.hashes[h]:
                    print(self.url+i)

    def normalizeHash(self, hash):
        if len(hash) > 5:
            norm_hash = hash[:5]
        else:
            norm_hash = hash
        return norm_hash


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print ("usage :")
        print ("{} commit".format(sys.argv[0]))
        sys.exit(1)

    raw_url = "http://lapekc6.dynamic.nsn-net.net:8010/"
    default_url = raw_url + "tgrid?length=100"
    opener = FancyURLopener({})
    f = opener.open(default_url)
    raw_content = f.read().decode('utf-8')
    p = Parser(raw_content, raw_url)
    p.start()
    p.report(sys.argv[1])


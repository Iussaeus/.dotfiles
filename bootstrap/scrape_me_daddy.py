#  pip install requests beautifulsoup4
import requests
from bs4 import BeautifulSoup

def extract_data(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    return soup

def get_link_tag(soup):
    for item in soup.select('.item'):
        if "M1220" in item.text and "tar.xz" in item.text:
            return item.select_one('a')

def extract_link(tag):
    return tag['onclick'].split("'")[-2]

if __name__ == "__main__":
    url = "https://download.gaomon.net/"
    print(extract_link(get_link_tag(extract_data(url))))

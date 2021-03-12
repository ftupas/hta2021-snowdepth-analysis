import requests
import os
import zipfile
from bs4 import BeautifulSoup

URL = 'https://data.coat.no'
DATASET = 'v_snowdepth_intensive_v1'
CWD = os.getcwd()
OUTPUT_PATH = os.path.join(CWD, 'data')

class Scraper:
    """
    Creates a Scraper Object

    :param root_url: Root URL of page being scraped
    """

    def __init__(self, root_url: str):
        self.root_url = root_url
        self.current_url = root_url


    def navigate(self, href_elem: str) -> str:
        """
        Navigate href links on the page

        :param href_elem: the href element you want to find
        :return: resulting URL
        """
        
        try:
            # Parse HTML and find href elements
            self.print_action(action='NAVIGATING', object=self.current_url)
            response = requests.get(self.current_url)
            soup = BeautifulSoup(response.content, 'html.parser')
            href_elems = soup.find_all('a', href=True)
            href_elem = list(filter(lambda x: href_elem in x['href'], href_elems))[0]

            # Set current URL
            self.current_url = self.root_url + href_elem['href']
            
            return self.current_url

        except requests.exceptions.ConnectionError as e:
            print(e)


    def download(self, url: str):
        """
        Download file locally

        :param url: download URL
        """

        self.print_action('DOWNLOADING',object=url)
        os.system(f'wget -O {DATASET}.zip {url}')
        self.print_action('DOWNLOADED', object=url)
        

    def unzip(self, file: str, output_path: str):
        """
        Unzip file to a folder and deletes file

        :param file: zipfile name
        :param output_path: output file path
        """

        self.print_action(action='UNZIPPING', object=file)
        try:
            with zipfile.ZipFile(os.path.join(CWD, file)) as _zip:
                _zip.extractall(output_path)
                
        except Exception as e:
            print(e)
        
        os.system(f'rm -rf {os.path.join(CWD, file)}')

        self.print_action(action='UNZIPPED', object=file)

    def print_action(self, action: str, object: str):
        print(f'--{action}--  {object}')

def main():

    # # Get zip download url
    scraper = Scraper(root_url=URL)
    datasets_url = scraper.navigate(href_elem='dataset')
    snowdepth_url = scraper.navigate(href_elem=DATASET)
    zip_download_url = scraper.navigate(href_elem='zip')

    # Download zip file
    scraper.download(zip_download_url)

    # Unzip file
    scraper.unzip(file=f'{DATASET}.zip', output_path=OUTPUT_PATH)

if __name__ == '__main__':
    main()
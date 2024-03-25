#!/home/catcher/wikipedia.org/venv/bin/python

import wikipediaapi
import pdfcrowd
import os

def download_web_page_as_pdf(url):
    # Create the directories if they don't exist
    os.makedirs('PDF', exist_ok=True)

    # Create a client instance
    client = pdfcrowd.HtmlToPdfClient('tomcatcher', '27ac2be090e40b8291a0bce5a2752e10')

    # Convert a web page and store the generated PDF into a pdf variable
    pdf = client.convertUrl(url)

    # Create a filename from the URL
    filename = url.replace('https://', '').replace('http://', '').replace('/', '_')

    # Save the PDF to a file
    with open(f'PDF/{filename}.pdf', 'wb') as f:
        f.write(pdf)

# Use the function
download_web_page_as_pdf('https://en.wikipedia.org/wiki/Bash_(Unix_shell)')
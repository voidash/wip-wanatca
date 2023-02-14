# Import Beautiful Soup
from bs4 import BeautifulSoup, NavigableString
import sys
# Create the document
with open(sys.argv[1],"r", encoding='ISO-8859-1') as file:
    doc = file.read();
    # Initialize the object with the document
    soup = BeautifulSoup(doc, "html.parser")
    # Get the whole body tag
    tag = soup.body
    table = tag.find('table',{'bgcolor': '#ffffcc', 'height': '50', 'width': '99%'})
    table.extract()

    logo = tag.find('img',{'src': '../AcoLogo.gif', 'alt': 'logo'})
    logo.extract()

    # find the first h3 
    with open(sys.argv[2]) as file:
        new_div_tag = soup.new_tag('div')
        a = file.read()
        new_div_tag.prettify(formatter=None)
        new_div_tag.string = NavigableString(a)

        subs = tag.find('h3')
        subs.clear()

        subs.insert_after(new_div_tag)
        # print(a)

    print(tag)
    # Print each string recursively
    # for string in tag.strings:
    #     print(string)
from datetime import datetime

import requests

API_URL = 'http://www.google.co.uk/finance/historical?cid={}&startdate=Jan+1,+2014&enddate={}&output=csv'

today = datetime.now().strftime('%b %d,%Y')
with open('portfolio_meta.txt') as fd:
    for line in fd:
        name, ticker, cid = line.strip().split(',')
        print(name)
        geturl = API_URL.format(str(cid), today)
        print(geturl)
        response = requests.get(geturl)
        if len(response.text) > 0:
            fname = '{}.csv'.format(name)
            with open(fname, 'w') as fd:
                for line in response.text.split('\n'):
                    if len(line) > 0:
                        dt, op, hi, lo, close, volume = line.split(',')
                        if dt != 'Date':
                            fd.write(
                                'insert into price select {},"{}",{},{},{},{},{};\n'.format(cid, dt, op, hi, lo, close,
                                                                                            volume))

import ConfigParser
import logging
import sqlite3
from datetime import datetime

import requests



def fixup(vals):
    ret = []
    for v in vals:
        if v == '-':
            v = -1
        ret.append(v)

    return ret


if __name__ == '__main__':
    config = ConfigParser.SafeConfigParser()
    config.read('portfolio.props')

    logging.basicConfig(format=config.get('logging', 'log_format'), \
                        filename=config.get('logging', 'filename').format(dir=config.get('logging', 'dir'),
                                                                          dt=str(datetime.now())[:10]), \
                        level=logging.DEBUG)
    logging.captureWarnings(True)

    iso_date_format = config.get('database', 'iso_date_format')
    insert_sql = config.get('database', 'insert_sql')
    last_price_sql = config.get('database', 'last_price_sql')

    db_filename = '{}/{}'.format(config.get('database', 'dir'), config.get('database', 'dbname'))
    with sqlite3.connect(db_filename) as conn:
        crsr = conn.cursor()

        # get max price date for each portfolio
        today = datetime.now()
        api_date_format = config.get('google.finance', 'url_date_format')
        price_date_format = config.get('google.finance', 'price_date_format')

        api_url = config.get('google.finance', 'api')
        formatted_end_date = api_date_format.format(dt=today)

        crsr.execute(last_price_sql)
        for row in crsr.fetchall():
            name, google_cid, iso_date = row
            if iso_date is None:
                iso_date = '20140101'
            end_date = datetime.strptime(str(iso_date), '%Y%m%d')
            formatted_start_date = api_date_format.format(dt=end_date)
            print('Updating {:20} {:20}  {dt:%b} {dt:%d},{dt:%Y}'.format(name, google_cid, dt=end_date))

            update_url = api_url.format(cid=google_cid, startdate=formatted_start_date, enddate=formatted_end_date)
            logging.debug('update url = {}'.format(update_url))
            response = requests.get(update_url)
            if response.status_code == 200 and len(response.text) > 0:
                for l in response.text.strip().split('\n'):
                    l_date, l_open, l_high, l_low, l_close, l_volume = (l.split(','))
                    if l_date != 'Date':
                        price_date = datetime.strptime(l_date, price_date_format)
                        if price_date > end_date:
                            l_open, l_high, l_low, l_close = fixup([l_open, l_high, l_low, l_close])
                            iso_price_date = datetime.strftime(price_date, iso_date_format)
                            sql = insert_sql.format(google_cid=google_cid, iso_date=iso_price_date, open=l_open,
                                                    high=l_high, low=l_low, close=l_close, volume=l_volume)
                            logging.debug('insert sql: {}'.format(sql))
                            # print('{} {}'.format(l_date, price_date))
                            conn.execute(sql)
                        else:
                            logging.info('skipping ' + l)

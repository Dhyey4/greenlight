import sqlite3
import psycopg2
from dateutil import tz
from datetime import datetime, timedelta, timezone
from time import sleep
from sendgrid.helpers.mail import Mail
from sendgrid import SendGridAPIClient


FROM_EMAIL = 'Wofemtech Solution <hello@wofemtech.com>'


def send_sendgrid_mail(to_email, template_id=None, purpose=None):
    print(15*"*")
    print(template_id)
    print(15*"*")
    if purpose == "welcome":
        message = Mail(
            from_email=FROM_EMAIL,
            to_emails=to_email,
            subject='Wofemtech Solution',
        )
        # pass custom values for our HTML placeholders
        message.template_id = template_id
        # message.dynamic_template_data = {
        #     'name': 'Jay ',
        #     'date': '1 July 2020'
        # }
        # create our sendgrid client object, pass it our key, then send and return our response objects
        try:
            # dhyey key test
            # sg = SendGridAPIClient('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')
            # wofemtech key
            sg = SendGridAPIClient('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')
            response = sg.send(message)
            code, body, headers = response.status_code, response.body, response.headers
            print("Response code:", code)
            print("Response headers:", headers)
            print("Response body:", body)
            print("Dynamic Messages Sent!")
        except Exception as e:
            print("Error: {0}".format(e))

def pg_utcnow():
    return datetime.utcnow().replace(
        tzinfo=psycopg2.tz.FixedOffsetTimezone(offset=0, name=None))

def main():
    connection = psycopg2.connect(user = "postgres",
                                      password = "password",
                                      host = "db",
                                      port = "5432",
                                      database = "postgres")
    cursor = connection.cursor()

    conn_sqlite = sqlite3.connect("cross_check.db")
    sqlite_cursor = conn_sqlite.cursor()
    create_table  = "CREATE TABLE IF NOT EXISTS users (id integer PRIMARY KEY, " \
                    "name text NOT NULL, email text, created_at datetime, reminder_flag BOOLEAN, welcome BOOLEAN, updated_at datetime, role_id integer);"
    sqlite_cursor.execute(create_table)
    conn_sqlite.commit()
    print("Connection Done!! ")
    while True:
        print("Checking....")

        # Checking for new user
        d = datetime.now(timezone.utc) - timedelta(minutes=2)
        time_check = d.strftime("%Y-%m-%d %H:%M:%S.%f")
        query = "SELECT name,email,role_id,created_at,updated_at FROM public.users where created_at >" + "'"+time_check+"';"
        # print(query)
        # query = "SELECT name,email,role_id,created_at,updated_at FROM public.users where created_at >'2020-06-12 12:01:06';"
        query_sqlite = ''' INSERT INTO users(name, email, created_at, reminder_flag, welcome, updated_at, role_id) VALUES(?,?,?,?,?,?,?) '''
        cursor.execute(query)
        record = cursor.fetchall()
        for raw in record:
            send_sendgrid_mail("", template_id=None, purpose='thankyou')
            data = [raw[0], raw[1], raw[3], False, False, raw[4], raw[2]]
            if raw[2] == 1 or raw[2] == 2:
                send_sendgrid_mail(raw[1], template_id='d-b8bde7c787d44339acba79ef4d0ded5b', purpose='welcome' )
            sqlite_cursor.execute(query_sqlite, data)
            conn_sqlite.commit()


        # checking for new approved usres
        sqlite_get_query = "SELECT email FROM users WHERE role_id=3"
        sqlite_cursor.execute(sqlite_get_query)
        all_records = sqlite_cursor.fetchall()

        update_query = "UPDATE users SET role_id=?,welcome=?  WHERE email=?"
        for raw in all_records:
            print(raw)
            get_data = "SELECT email,role_id FROM public.users WHERE email='"+raw[0]+"';"
            cursor.execute(get_data)
            all_data_pos = cursor.fetchall()
            print(all_data_pos)
            if len(all_data_pos) > 0:
                if all_data_pos[0][1] == 1 or all_data_pos[0][1] == 2:
                    send_sendgrid_mail(all_data_pos[0][0], template_id='d-b8bde7c787d44339acba79ef4d0ded5b', purpose='welcome' )
                    sqlite_cursor.execute(update_query, [all_data_pos[0][1], 1, raw[0]])
                    conn_sqlite.commit()

        # 13 days after mail sequence
        # sqlite_get_query = "SELECT email, created_at FROM users WHERE reminder_flag=0"
        # update_flag_query = "UPDATE users SET reminder_flag=?  WHERE email=?"
        # sqlite_cursor.execute(sqlite_get_query)
        # all_records = sqlite_cursor.fetchall()
        # for raw in all_records:
        #     raw_date = datetime.strptime(raw[1], "%Y-%m-%d %H:%M:%S.%f")
        #     current_time_string = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S.%f")
        #     current_time = datetime.strptime(current_time_string, "%Y-%m-%d %H:%M:%S.%f")
        #     difference = current_time - raw_date
        #     duration_in_s = difference.total_seconds()
        #     days = difference.days
        #     minutes = divmod(duration_in_s, 60)[0]
        #     if minutes > 60:
        #         send_sendgrid_mail("60 Minutes Reminder")
        #         sqlite_cursor.execute(update_flag_query, [1, raw[0]])
        #         conn_sqlite.commit()
        #     print("difference in second", duration_in_s)
        #     print("difference in minutes", minutes)
        #     print("difference in days", days)

        sleep(120)
    conn_sqlite.close()
    cursor.close()
    connection.close()
    print("PostgreSQL connection is closed")


if __name__ == '__main__':
    main()

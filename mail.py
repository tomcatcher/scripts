#!/usr/bin/python

import imaplib
import email
from email.header import decode_header
from email.utils import parsedate_to_datetime
import os

# Your email and password
email_user = 'tom.catcher@gmail.com'
email_pass = 'tsfrkqeackgpcxmh'

# Connect to Gmail's IMAP server
mail = imaplib.IMAP4_SSL('imap.gmail.com')
mail.login(email_user, email_pass)
mail.select('inbox')

# Search for all emails
status, messages = mail.search(None, 'ALL')
if status != 'OK':
    print("No emails found!")
    exit()

# Convert messages to a list of email IDs
messages = messages[0].split(b' ')

with open('inbox.box', 'a', encoding='utf-8') as f:
    for mail_id in messages:
        # Fetch the email's bytes
        _, msg_data = mail.fetch(mail_id, '(RFC822)')
        for response_part in msg_data:
            if isinstance(response_part, tuple):
                # Parse the bytes to an email message
                msg = email.message_from_bytes(response_part[1])

                # Parse the date of the email
                date = parsedate_to_datetime(msg['Date'])

                # Output the full date and time
                print(f'Processing email from date and time: {date}')

                # Ignore emails not from 2019 onwards
                if date.year < 2019:
                    continue

                # Decode the email subject
                subject = msg["subject"]
                if subject is None:
                    subject = "EMPTY-SUBJECT"
                subject, encoding = decode_header(subject)[0]
                if isinstance(subject, bytes):
                    # decode to str
                    try:
                        # if encoding is None, use default 'utf-8'
                        subject = subject.decode(encoding if encoding else 'utf-8', errors='ignore')
                    except LookupError:
                        subject = subject.decode('utf-8', errors='ignore')

                # Transcode the filename to utf8, trim the beginning and end from empty spaces, replace empty spaces and commas and slashes with a hyphen
                subject = subject.encode('utf-8').decode('utf-8').strip().replace(' ', '-').replace(',', '-').replace('/', '-').replace('\\', '-')

                # Write the headers to the file
                for header in ['From', 'To', 'Subject', 'Date']:
                    f.write(f'{header}: {msg[header]}\n')

                # Append the full email to the inbox.box file
                if msg.is_multipart():
                    for part in msg.get_payload():
                        if part.get_content_type() == 'text/plain':
                            f.write(part.get_payload(decode=True).decode('utf-8', errors='ignore'))
                else:
                    f.write(msg.get_payload(decode=True).decode('utf-8', errors='ignore'))
                f.write('\n' + '#' * 80 + '\n')

# Close the connection and logout
mail.close()
mail.logout()
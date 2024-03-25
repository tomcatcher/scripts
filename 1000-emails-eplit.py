#!/home/catcher/mail/all/mailsplit/bin/python

import os

def split_file(filename):
    email_count = 0
    file_count = 0
    current_file = None
    with open(filename, 'r') as f:
        for line in f:
            if line.strip() == '#' * 80:
                email_count += 1
                if email_count % 250 == 0 or (current_file and os.path.getsize(current_file.name) >= 2 * 1024 * 1024):
                    file_count += 1
                    if current_file:
                        current_file.close()
                    current_file = open(f'split_{file_count}.txt', 'w')
            if current_file:
                current_file.write(line)
        if current_file:
            current_file.close()

split_file('inbox.box.txt')
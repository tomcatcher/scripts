#!/usr/bin/python

import uuid

def split_file(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()

    delimiter = '#' * 80
    output_lines = []
    for line in lines:
        if line.strip() == delimiter:
            # Write the current lines to a new file
            output_filename = str(uuid.uuid4()) + '.eml'
            with open(output_filename, 'w') as output_file:
                output_file.writelines(output_lines)
            # Clear the current lines
            output_lines = []
        else:
            output_lines.append(line)

    # Write the remaining lines to a new file
    if output_lines:
        output_filename = str(uuid.uuid4()) + '.txt'
        with open(output_filename, 'w') as output_file:
            output_file.writelines(output_lines)

# Use the function
split_file('inbox.box.txt')
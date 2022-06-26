"""
This program is used to merge two files with at least one column name in common.

USAGE : {MANDATORY} -f1 [FILE_1] -f2 [FILE_2] -cn [COLUMN_NAME]
"""

########################## MODULES TO IMPORT ##################################

import argparse
import os
import pandas as pd

###############################################################################

def isfile(path):
    """
    Check if path is an existing file
    """

    if not os.path.isfile(path):

        if os.path.isdir(path):
            err = f"{path} is a directory"
        else:
            err = f"{path} does not exist"

        raise argparse.ArgumentTypeError(err)

    return path


def arguments():
    """
    set arguments
    """

    parser = argparse.ArgumentParser()

    # Mandatory arguments
    parser.add_argument("-f1", "--file_1", dest = "file_1",
        type = isfile, required = True,
        help = "a first file containing data to be merged with the second one")
    parser.add_argument("-f2", "--file_2", dest = "file_2",
        type = isfile, required = True,
        help = "a second file containing data to be merged with the first one")
    parser.add_argument("-cn", "--column_name", dest = "column_name",
        type = str, required = True,
        help = "the name of the column used as the basis of the merge")


    return parser.parse_args()


def read_table_file(file_1, file_2):
    """
    Reads csv files and retrieves pandas dataframes
    """

    df1 = pd.read_table(file_1, sep = "[,;]", engine = "python")
    df2 = pd.read_table(file_2, sep = "[,;]", engine = "python")

    return df1, df2


def main():
    """
    Main program function
    """

    # get arguments
    args = arguments()
    
    # Create pandas dataframes from csv file
    df1, df2 = read_table_file(args.file_1, args.file_2)

    # Merge both dataframe into one final dataframe
    final_df = pd.merge(df1, df2, on = args.column_name, how = "outer")
   
    # define the path to the file to be saved
    final_file = "merged_file.csv"

    # save the dataframe in a csv file
    final_df.to_csv(final_file, index = False, na_rep = "NA")


if __name__ == '__main__':
    main()
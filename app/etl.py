import os
import glob
import csv
import pandas as pd
import shutil

CWD = os.getcwd()
DATA_PATH = os.path.join(CWD, 'raw_data')
OUTPUT_FOLDER = os.path.join(CWD, 'data')


def get_files(path: str, format: str) -> list:
    """
    Gets the list of text files in a folder
    
    :param path: folder path
    :param format: file extension format
    :return: list of file paths
    """

    for root, _ , files in os.walk(path):
        files = glob.glob(os.path.join(root, f'*{format}'))

    return files


def is_int(string: str) -> bool:
    """
    Gets an string and tries to convert it to int

    :param string: string to be converted
    :return: True or False
    """

    try:
        int(string)
        return True
    
    except ValueError:
        return False


def is_dated_file(file: str) -> bool:
    """
    Gets a file and checks if it's dated

    :param file: file to be checked
    :return: True of False
    """

    if is_int(file.split('.csv')[0].split('_')[-1]):
        return True
    
    else:
        return False


def collate_csv(files: list):
    """
    Combines csv files 

    :param files: files to be combined
    """
    
    filename = '_'.join(os.path.basename(files[0]).split('_')[:-1])
    output = '_'.join(files[0].split('_')[:-1]) + '_data.csv'
    print(f'--CREATING-- {filename}_.csv')

    # Create DataFrames from csv and concatenate
    df_list = [pd.read_csv(file) for file in files]
    df = pd.concat(df_list)
    
    # Save to csv
    df.to_csv(output, index=False)


def convert_txt_to_csv(filename: str, delimiter: str):
    """
    Converts the text file to csv

    :param filename: filepath of text file
    :param delimiter: file delimiter
    :param output: csv output filepath
    """

    print(f'--CONVERTING--  {os.path.basename(filename)}')
    with open(filename, 'r') as _input, open(f'{filename[:-4]}.csv', 'w') as _output:
        lines = csv.reader(_input, delimiter=delimiter)
        writer = csv.writer(_output)
        writer.writerows(lines)
    

def main():

    # Get data files
    files = get_files(path=DATA_PATH, format='.txt')

    # Convert files to csv
    for file in files:
        convert_txt_to_csv(filename=file, delimiter=';')

    # Filter and combine dated files
    csv_files = get_files(path=DATA_PATH, format='.csv')
    dated_files = list(filter(lambda x: is_dated_file(x), csv_files))
    df = collate_csv(files=dated_files)

    # Move files to raw folder
    data_files = list(filter(lambda x: not is_dated_file(x), csv_files))
    try:
        os.mkdir(OUTPUT_FOLDER)

    except FileExistsError:
        pass
    for data_file in data_files:
        data_filename = os.path.basename(data_file)
        os.system(f'cp {data_file} {os.path.join(OUTPUT_FOLDER, data_filename)}')
        print(f'--MOVING--  {data_filename} to data')
    
    # Clean folder
    shutil.rmtree(DATA_PATH)

if __name__ == '__main__':
    main()
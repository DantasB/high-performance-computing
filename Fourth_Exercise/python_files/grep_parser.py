import sys
import re


def splitter(text: str, splitter: str) -> list:
    """Receives a text to be splitted

    Args:
        text (str): string input
        splitter (str): text splitter

    Returns:
        list: array with the content splitted
    """
    return text.split(splitter)


def get_csv_headers(archive_path: str) -> None:
    """Receives a txt archive and extract the possible headers names

    Args:
        archive_path (str): path of the archive to get the headers names
    """
    line = ''
    with open(archive_path, 'r') as file:
        line = file.readline()
        line = splitter(line, '.out:')[0]

    line = ",".join(re.findall("[a-zA-Z]+", line))
    line += "," + "GLOPs"
    print(line)


def parse_line(line: str) -> bool:
    """Receives a line to be parsed as csv

    Args:
        line (str): the txt line

    Returns:
        bool: False if the parser failed
    """
    splitted_line = splitter(line, '.out:')
    if len(splitted_line) != 2:
        return False

    parameters = splitted_line[0]
    gflops = splitter(splitted_line[1], '   ')
    if len(gflops) != 2:
        return False

    parsed_line = ""
    parsed_line = ",".join(re.findall('[0-9]+', parameters))
    parsed_line += "," + gflops[1].strip()

    print(parsed_line)

    return True


def parse_text(archive_path: str) -> bool:
    """Receives a txt archive to be parsed as csv

    Args:
        archive_path (str): path of the archive to be converted

    Returns:
        bool: False if the parser failed
    """
    with open(archive_path, 'r') as file:
        for line in file:
            if not parse_line(line):
                return False
    return True


if __name__ == "__main__":
    try:
        if(len(sys.argv) != 2):
            raise Exception('Could not convert the file. Check your arguments')
    except:
        raise Exception('Could not convert the file. Check your arguments')

    archive_path = sys.argv[1]

    get_csv_headers(archive_path)

    if not parse_text(archive_path):
        raise Exception('Failed while parsing the text')

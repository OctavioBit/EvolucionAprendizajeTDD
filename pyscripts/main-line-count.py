import os
import csv

def main():
    
    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\st\\"    
    #csvFile = open('lineCount1C2021.csv', 'w', encoding='UTF8', newline='')

    stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\st\\"    
    csvFile = open('lineCount2C2020.csv', 'w', encoding='UTF8', newline='')

    csvWriter = csv.writer(csvFile)

    
    headers = ["Group","Excercise","Lines"]
    csvWriter.writerow(headers)

    for filename in os.listdir(stDirectory):
        stFileName = os.path.join(stDirectory, filename)

        stFile = open(stFileName)

        lineCount = 0

        for line in stFile:

            if line == '\n' or line == '\t\n' or line[0] == '!':
                continue

            lineCount+=1

        filenameParts = filename[0:filename.index('.')].split("_")

        csvRow = [filenameParts[0],filenameParts[1],lineCount]
        csvWriter.writerow(csvRow)

        stFile.close()

    csvFile.close()

main()
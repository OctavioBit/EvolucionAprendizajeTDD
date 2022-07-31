import os
import csv

def main():
    
    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\test\\"    
    #csvFile = open('lineTest.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\sln\\"    
    #csvFile = open('LineCountSolution2C2020.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\sln\\"    
    #csvFile = open('LineCountSolution1C2021.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\st\\"    
    #csvFile = open('LineCountExcercises1C2021.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\st\\"    
    #csvFile = open('LineCountExcercises2C2020.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\stParciales1C2021\\"
    #csvFile = open('LineCountParciales1C2021.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\stSolucionesParcial1C2021\\"
    #csvFile = open('LineCountSolParcial1C2021.csv', 'w', encoding='UTF8', newline='')

    stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\stParciales2C2020\\"
    csvFile = open('LineCountParciales2C2020.csv', 'w', encoding='UTF8', newline='')

    #stDirectory = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\stSolucionesParcial2C2020\\"
    #csvFile = open('LineCountSolParcial2C2020.csv', 'w', encoding='UTF8', newline='')
    
    csvWriter = csv.writer(csvFile)
    
    headers = ["Group","Excercise","TestLines","ModelLines"]
    csvWriter.writerow(headers)
    
    for filename in os.listdir(stDirectory):
        stFileName = os.path.join(stDirectory, filename)

        stFile = open(stFileName)

        testLineCount = 0
        modelLineCount = 0
        countingModelLines = False

        for line in stFile:

            if line == '\n' or line == '\t\n' or line[0] == '!':
                continue

            if not countingModelLines:
                countingModelLines = " subclass: #" in line and not "TestCase" in line

            if countingModelLines:
                modelLineCount+=1
            else:
                testLineCount+=1

        filenameParts = filename[0:filename.index('.')].split("_")

        csvRow = [filenameParts[0],filenameParts[1],testLineCount,modelLineCount]
        csvWriter.writerow(csvRow)

        stFile.close()

    csvFile.close()

main()
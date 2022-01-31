# https://python.plainenglish.io/making-plots-with-the-pandas-groupby-ac492941af28

from itertools import cycle
from os import sep
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import csv

def printCorrectEx(exercise):

    MAX_STATE_TIME=60
        
    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\2C2020EjerciciosTDD.csv")
    aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\1C2021EjerciciosTDD.csv")
    #aDataFrame = aDataFrame[aDataFrame["Exercise"]==exercise]
    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]
        
    grCorrect = aDataFrame.groupby(["Repository"])["IsCorrect"].sum().fillna(0)
    grAll = aDataFrame.groupby(["Repository"])["IsCorrect"].count().fillna(0)
    grPorc = (grCorrect/grAll)*100
    grTime = aDataFrame.groupby(["Exercise"])["Time"].sum().fillna(0)
    grState = aDataFrame.groupby(["State"])["Time"].sum().fillna(0)
    grTimeRepository = aDataFrame.groupby(["Repository"])["Time"].sum().fillna(0)
   
    GROUP_CANT = 25
    
    print(exercise + " Correctos ")
    for groupNumber in range(1,GROUP_CANT+1):        
        if groupNumber in grPorc:
            print(grPorc[groupNumber])
        else:
            print(-1)

    countCorrect = aDataFrame[aDataFrame["IsCorrect"]==1].size
    countAll = aDataFrame.size
    porc = (countCorrect/countAll) * 100

    print(exercise + " correctos %" + " " + str(porc) )
    print(exercise + " tiempo ")
    print(grTime)
    print(grState)

    print("Tiempo de todos los ejercicios por repositorio")
    print(grTimeRepository)
    
def extractTDDCycles():

    WRITING_FAILING_TEST = "WR"
    RED = "RE"    
    REFACTOR = "RF"
    GREEN = "GR"   
    MAX_STATE_TIME=60 

    aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\2C2020EjerciciosTDD.csv")
    csvFile = open('cyclesFile2C2020.csv', 'w', encoding='UTF8', newline='')

    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\1C2021EjerciciosTDD.csv")
    #csvFile = open('cyclesFile1C2021.csv', 'w', encoding='UTF8', newline='')

    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\test.csv")
    #csvFile = open('cyclesTest.csv', 'w', encoding='UTF8', newline='')

    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]

    csvWriter = csv.writer(csvFile)
    headers = ["Group","Time","Exercise","Cycle Number"]
    csvWriter.writerow(headers)

    firstRow = aDataFrame.head(1)

    exercise = firstRow["Exercise"][2]
    group = firstRow["Repository"][2]
    state = firstRow["State"][2]
    cycleNumber = 1
    acumTime = 0

    for i, row in aDataFrame.iterrows():

        if i == 0:
            continue

        nextExercise = row["Exercise"]
        nextGroup = row["Repository"]
        nextState = row["State"]

        if exercise != nextExercise or group != nextGroup:
            cycleNumber = 1
            acumTime = 0            

        if state == WRITING_FAILING_TEST:

            if nextState == RED or nextState == WRITING_FAILING_TEST:
                acumTime += row["Time"]                
            else:                
                acumTime = 0
                        
        if state == RED:

            if nextState == RED or nextState == GREEN:
                acumTime += row["Time"]                
            else:                
                acumTime = 0                

        if state == GREEN:

            if nextState == WRITING_FAILING_TEST:
                
                if acumTime > 0:
                    line = [group,acumTime,exercise,cycleNumber]
                    csvWriter.writerow(line)
                    acumTime = 0
                    cycleNumber += 1

            elif nextState == REFACTOR or nextState == GREEN:
                acumTime += row["Time"]
            else:                
                acumTime = 0                

        if state == REFACTOR:

            if nextState == GREEN or nextState == REFACTOR:
                acumTime += row["Time"]
            else:                
                acumTime = 0

        exercise = nextExercise 
        group = nextGroup
        state = nextState

    csvFile.close()

             
extractTDDCycles()
#printCorrectEx("MR")
#printCorrectEx("PO1")
#printCorrectEx("PO2")
#printCorrectEx("MRR")
#printCorrectEx("TEL")
#printCorrectEx("TL1")
#printCorrectEx("TL2")
#printCorrectEx("TL3")

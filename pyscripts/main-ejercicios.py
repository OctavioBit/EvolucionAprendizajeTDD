# https://python.plainenglish.io/making-plots-with-the-pandas-groupby-ac492941af28

from itertools import cycle
from math import fabs
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
    MAX_STATE_TIME=60 * 10

    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\2C2020EjerciciosTDD.csv")
    #csvFile = open('cyclesFile2C2020.csv', 'w', encoding='UTF8', newline='')

    aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\1C2021EjerciciosTDD.csv")
    csvFile = open('cyclesFile1C2021.csv', 'w', encoding='UTF8', newline='')

    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\test.csv")
    #csvFile = open('cyclesTest.csv', 'w', encoding='UTF8', newline='')

    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]

    csvWriter = csv.writer(csvFile)
    headers = ["Group","Time","Exercise","Cycle Number","Cycle is correct"]
    csvWriter.writerow(headers)
    
    cycleNumber = 1
    acumTime = 0
    cicleIsCorrect = True

    aDataFrame.reset_index()

    exercise = ""
    group = ""
    state = ""
    prevExercise = ""
    prevGroup = ""
    prevState = ""
    
    for i, row in aDataFrame.iterrows():

        acumTime += row["Time"]

        #The first row already was readed
        if i == 0:
            prevExercise = row["Exercise"]
            prevGroup = row["Repository"]
            prevState = row["State"]

            exercise = row["Exercise"]
            group = row["Repository"]
            state = row["State"]

            continue
                
        prevExercise = exercise
        prevGroup = group
        prevState = state

        exercise = row["Exercise"]
        group = row["Repository"]
        state = row["State"]

        if row["IsCorrect"] == 0:
            cicleIsCorrect = False

        if exercise != prevExercise or group != prevGroup:
            cycleNumber = 1
            acumTime = 0
            cicleIsCorrect = True
            continue
                
        if state == WRITING_FAILING_TEST and prevState != WRITING_FAILING_TEST:
            
            if acumTime > 0:
                line = [group,acumTime,exercise,cycleNumber, "1" if cicleIsCorrect else "0"]
                csvWriter.writerow(line)
                acumTime = 0
                cycleNumber += 1
                cicleIsCorrect = True

            continue

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

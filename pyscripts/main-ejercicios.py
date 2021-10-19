# https://python.plainenglish.io/making-plots-with-the-pandas-groupby-ac492941af28

from os import sep
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def printCorrectEx(exercise):

    MAX_STATE_TIME=60
        
    aDataFrame = pd.read_csv("F:\\data\\Tesis\\data\\Analisis\\python\\1C2021\\1C2021EjerciciosTDD.csv")
    #aDataFrame = aDataFrame[aDataFrame["Exercise"]==exercise]
    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]    
        
    grCorrect = aDataFrame.groupby(["Repository"])["IsCorrect"].sum().fillna(0)
    grAll = aDataFrame.groupby(["Repository"])["IsCorrect"].count().fillna(0)
    grPorc = (grCorrect/grAll)*100
    grTime = aDataFrame.groupby(["Exercise"])["Time"].sum().fillna(0)
    grState = aDataFrame.groupby(["State"])["Time"].sum().fillna(0)
   
    GROUP_CANT = 25
    
    print(exercise + "Correctos ")
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
    

printCorrectEx("MR")
#printCorrectEx("PO1")
#printCorrectEx("PO2")
#printCorrectEx("MRR")
#printCorrectEx("TL1")
#printCorrectEx("TL2")
#printCorrectEx("TL3")
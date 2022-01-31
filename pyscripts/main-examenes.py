# https://python.plainenglish.io/making-plots-with-the-pandas-groupby-ac492941af28

from os import sep
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def printCorrectEx():

    MAX_STATE_TIME=60
        
    aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\Parcial2TDDGuru.csv")
    #aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\Parcial2TDDGuru.csv")

    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]    
        
    grCorrect = aDataFrame.groupby(["Student"])["IsCorrect"].sum().fillna(0)
    grAll = aDataFrame.groupby(["Student"])["IsCorrect"].count().fillna(0)

    grTestCount = aDataFrame.groupby(["Student"])["TestCount"].max().fillna(0)
    grPorc = (grCorrect/grAll)*100
    grTime = aDataFrame.groupby(["State"])["Time"].sum().fillna(0)
        
    STUDENT_CANT = 50
    
    print("Cantidad test")
    for groupNumber in range(1,STUDENT_CANT+1):        
        if groupNumber in grPorc:            
            print(grTestCount[groupNumber])
        else:            
            print(-1)
       
    print("Porcentajes OK")
    for groupNumber in range(1,STUDENT_CANT+1):        
        if groupNumber in grPorc:            
            print(grPorc[groupNumber])
        else:            
            print(-1)
    
    print("Tiempos")
    print(grTime)
      
    countCorrect = aDataFrame[aDataFrame["IsCorrect"]==1].size    
    countAll = aDataFrame.size
    porc = (countCorrect/countAll) * 100
    
    print(" PORC OK " + str(porc) )

printCorrectEx()

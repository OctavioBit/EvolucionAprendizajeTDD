# https://python.plainenglish.io/making-plots-with-the-pandas-groupby-ac492941af28

from os import sep
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

#Pacial 2C 2020
#students = [16,17,18,31,12,26,25,27,28,0,19,37,32,38,30,39,34,29,10,14,11,43,3,44,2,40,35,13,5,47,1,45,41,6,22,36,42,9,46,8,23,21,24,15,20,4,16]

students = [50,23,25,35,1,50,2,6, 7, 5, 31, 28, 11, 13, 32, 16, 41, 30, 24, 38, 43, 9, 39, 15, 4, 37, 18, 45, 49, 14, 21, 46, 44, 36, 34, 27, 17, 19, 3, 42, 22, 33, 8, 10, 40, 29, 26, 12, 47, 4]

dictNotas = {}

def printCorrectEx():

    MAX_STATE_TIME=60
        
    aDataFrame = pd.read_csv("F:\\data\Tesis\\data\\Analisis\\python\\1C2021\\Parcial2NotasExport.csv")
    
    studentsCount = 50
    
    for s in range(1,studentsCount+1):

        studentNumber = str(s)
        scoreTDDStudent = 0
        
        for i in range(1,len(aDataFrame)):
            
            #if aDataFrame["Tipo"][i] == "T":
            scoreTDDStudent += aDataFrame["Porcentaje"][i]*aDataFrame[studentNumber][i]
        
        dictNotas[studentNumber] = str(scoreTDDStudent)
    
    for s in range(1,studentsCount+1):
        studentNumber = str(s)
        if studentNumber in dictNotas:
            print(s,dictNotas[studentNumber])
        else:
            print(s,"-1")

printCorrectEx() 

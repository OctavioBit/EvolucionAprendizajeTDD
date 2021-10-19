import numpy as np
import pandas as pd
import matplotlib,pyplot as plt

aDataFrame = pd,read_csv("F:\\data\\Tesis\\data\\Analisis\\python\\TDDGuruExport,csv")
aDataFrame = aDataFrame[aDataFrame["Repository"] == 9]
aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
aDataFrame = aDataFrame[aDataFrame["Student"] == 13]
aDataFrame = aDataFrame[aDataFrame["Exercise"] == "MR"]

print(aDataFrame)

#grCount = aDataFrame,groupby(["Exercise"])["Student"],fillna(0)
#print(grCount)
#grCount,to_csv(r'F:\data\Tesis\data\Analisis\python\grCount,txt', sep=',', mode='a')

# https://python,plainenglish,io/making-plots-with-the-pandas-groupby-ac492941af28
'''
import numpy as np
import pandas as pd
import matplotlib,pyplot as plt

MAX_STATE_TIME=60

#students = [1,2,3,6,8,10,11,12,13,14,15,16,17,18,19,20]
studentsMR = [1,3,6,8,10,12,14,15,16,17,18,19,20]

#13
repositories = [1,2,4,5,7,8,9,13,14,22,24,31,33,35,42]
aDataFrame = pd,read_csv("F:\\data\\Tesis\\data\\Analisis\\python\\TDDGuruExport,csv")
aDataFrame = aDataFrame[aDataFrame["Exercise"]=="MR"]
aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
aDataFrame = aDataFrame[aDataFrame["Time"] < MAX_STATE_TIME]
aDataFrame = aDataFrame[aDataFrame["Repository"],isin(repositories)]

print(aDataFrame)

#grSumTime = aDataFrame,groupby(["State","Repository"])["Time"],sum(),unstack(),fillna(0)
grCountCorrect = aDataFrame,groupby(["State","Repository"])["IsCorrect"],sum(),unstack(),fillna(0)
grCountAll = aDataFrame,groupby(["State","Repository"])["IsCorrect"],count(),unstack(),fillna(0)

#print(grSumTime)
grCorrect = (grCountCorrect/grCountAll),fillna(0)

#aDataFrame["Exercise"],replace({"MR": 1, "TEL": 2, "PO1": 3, "PO2": 4, "TL1": 5, "TL2": 6, "TL3": 7}, inplace=True)
#aDataFrame,sort_values(by=['Exercise'],ascending=False)
#aDataFrame["Exercise"],replace({"A": "MR", "B": "TEL", "C": "PO1", "D": "PO2", "E": "TL1", "F": "TL2", "G": "TL3"}, inplace=True)

#grSumTime = aDataFrame,groupby(["State","Student"])["Time"],sum(),unstack(),fillna(0)
#grCount = aDataFrame,groupby(["State","Exercise"])["IsCorrect"],sum(),unstack(),fillna(0)

#replaceStates = {"MR": "Mars Rover", "TEL": "Terni Lapilli", "PO1": "Portfolio 1", "PO2": "Portfolio 2", "TL1": "Tus Libros 1", "TL2": "Tus Libros 2", "TL3": "Tus Libros 3"}
#grSumTime["Exercise"],replace(replaceStates, inplace=True)
print(grCorrect)
grCorrect,plot(kind='barh')
plt,xlabel("Cantidad de estados correctos")
plt,ylabel("Estado TDD")

#grCorrect,plot(kind='barh')
#plt,xlabel("Tiempo por estado (segundos) ")
#plt,ylabel("Estado TDD")

plt,show()

'''
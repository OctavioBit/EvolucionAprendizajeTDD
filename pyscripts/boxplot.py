import pandas as pd
import matplotlib.pyplot as plt

'''
#aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\1C2021EjerciciosTDD.csv")
aDataFrame = pd.read_csv("F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\EjerciciosTDD.csv")
aDataFrame = aDataFrame[aDataFrame["Exercise"] == "TL3"]
aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
aDataFrame = aDataFrame[aDataFrame["Time"] < 100]
aDataFrame = aDataFrame["Time"]

fig1, ax1 = plt.subplots()
ax1.set_title('Box Plot')
ax1.boxplot(x=aDataFrame,autorange=True)

plt.show()
'''

def getDataframe(exercise,csvFileName):

    aDataFrame = pd.read_csv(csvFileName)
    aDataFrame = aDataFrame[aDataFrame["Exercise"] == exercise]
    aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
    aDataFrame = aDataFrame[aDataFrame["Time"] < 100]
    aDataFrame = aDataFrame["Time"]

    return aDataFrame

def buildBoxPlots2020():

    CUAT2C2020 = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\2C2020\\EjerciciosTDD.csv"

    dataframes = [
        getDataframe("MR",CUAT2C2020),
        getDataframe("TEL",CUAT2C2020),
        getDataframe("PO1",CUAT2C2020),
        getDataframe("PO2",CUAT2C2020),
        getDataframe("TL1",CUAT2C2020),
        getDataframe("TL2",CUAT2C2020),
        getDataframe("TL3",CUAT2C2020)
    ]

    fig1, ax1 = plt.subplots()
    ax1.set_title('2C 2020')
    ax1.boxplot(x=dataframes,autorange=True,labels=["MR","TEL","PO1","PO2","TL1","TL2","TL3"])
    plt.show()

def buildBoxPlots2021():

    CUAT1C2021 = "F:\\data\\Tesis\\EvolucionAprendizajeTDD\\pyscripts\\1C2021\\1C2021EjerciciosTDD.csv"

    dataframes = [
        getDataframe("MR",CUAT1C2021),
        getDataframe("MRR",CUAT1C2021),
        getDataframe("PO1",CUAT1C2021),
        getDataframe("PO2",CUAT1C2021),
        getDataframe("TL1",CUAT1C2021),
        getDataframe("TL2",CUAT1C2021),
        getDataframe("TL3",CUAT1C2021)
    ]

    fig1, ax1 = plt.subplots()
    ax1.set_title('1C 2021')
    ax1.boxplot(x=dataframes,autorange=True,labels=["MR","MRR","PO1","PO2","TL1","TL2","TL3"])
    plt.show()


#buildBoxPlots2020()
buildBoxPlots2021()

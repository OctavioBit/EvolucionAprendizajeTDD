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

def buildBoxPlotParcial():

    data2c2020 = [93.95973154,81.65829146,78.88888889,77.68595041,74.93796526,72.58687259,70.79646018,70.73732719,65.11627907,62.61980831,61.68831169,60.9561753,60.2905569,59.62264151,59.00900901,58.78378378,55.49872123,55.13307985,48.40182648,45.53191489,44.44444444,37.32718894,34.14634146,26.02739726,22.77777778,20.21978022,19.88071571,15.87301587,14.42542787,13.77952756,9.574468085,4.784688995,0,0,0]
    data1c2021 = [97.58551308,96.95652174,96.80232558,90.98143236,89.03743316,87.53894081,86.75958188,86.16714697,84.55008489,80.04587156,80,78.32369942,75.91836735,75.75,74.79452055,71.08433735,68,67.8125,66.43109541,60.91370558,60.48951049,58.37320574,49.82817869,46.31147541,39.89637306,33.66834171,29.07348243,25.99531616,25.98425197,24.62121212,18.48184818,13.02931596,12.74509804,10.37924152,0.6756756757,0.2849002849]
    fig1, ax1 = plt.subplots()
    ax1.set_title('Porcentaje de estados correctos de TDD en el parcial')
    ax1.boxplot(x=[data2c2020,data1c2021],autorange=True,labels=["2C 2020","1C 2021"])
    plt.show()

def buildBoxPlotCantidadTests():

    data2c2020 = [42,36,34,34,29,28,27,25,24,23,23,23,22,21,21,21,20,20,18,16,16,16,14,13,13,13,12,12,12,11,11,7,6,0,0]
    data1c2021 = [42,36,35,34,32,30,26,25,24,23,23,22,22,22,20,20,20,20,20,18,18,18,17,16,16,16,16,16,16,15,13,13,12,12,11,8,0]
    fig1, ax1 = plt.subplots()
    ax1.set_title('Cantidad de tests en el parcial')
    ax1.boxplot(x=[data2c2020,data1c2021],autorange=True,labels=["2C 2020","1C 2021"])
    plt.show()

def buildBoxPlotNotaTDDParcial():

    data2c2020 = [95.65217391,81.5942029,78.26086957,77.68115942,74.7826087,74.20289855,73.1884058,72.46376812,65.50724638,61.44927536,61.15942029,60.14492754,59.42028986,57.97101449,56.88405797,56.66666667,56.52173913,53.47826087,53.33333333,52.89855072,52.46376812,51.8115942,50.28985507,48.84057971,48.55072464,47.46376812,46.37681159,45.65217391,45.65217391,45.28985507,44.92753623,44.20289855,44.05797101,43.04347826,41.30434783,38.11594203,37.82608696,37.39130435,36.37681159,35.50724638,24.7826087,23.91304348,14.13043478,12.02898551,10.14492754]
    data1c2021 = [92.85714286,92.85714286,92.85714286,92.85714286,92.85714286,92.85714286,91.42857143,91.42857143,89.28571429,85.71428571,85.71428571,85.71428571,85.71428571,77.85714286,74.28571429,72.85714286,71.42857143,71.42857143,64.28571429,64.28571429,64.28571429,58.57142857,57.14285714,57.14285714,57.14285714,50.71428571,50,50,46.42857143,46.42857143,44.64285714,44.64285714,35.71428571,34.28571429,33.92857143,32.14285714,32.14285714,32.14285714,27.85714286,26.78571429,24.28571429,23.57142857,14.28571429,12.85714286]
    fig1, ax1 = plt.subplots()
    ax1.set_title('Nota TDD en el parcial')
    ax1.boxplot(x=[data2c2020,data1c2021],autorange=True,labels=["2C 2020","1C 2021"])
    plt.show()

#buildBoxPlots2020()
#buildBoxPlots2021()
#buildBoxPlotParcial()
#buildBoxPlotCantidadTests()
#buildBoxPlotNotaTDDParcial()
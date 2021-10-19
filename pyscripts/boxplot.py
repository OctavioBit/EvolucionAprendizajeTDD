import pandas as pd
import matplotlib.pyplot as plt

aDataFrame = pd.read_csv("F:\\data\\Tesis\\data\\Analisis\\python\\TDDGuruExport.csv")
aDataFrame = aDataFrame[aDataFrame["Exercise"] == "PO2"]
aDataFrame = aDataFrame[aDataFrame["Time"] > 0]
aDataFrame = aDataFrame[aDataFrame["Time"] < 100]
aDataFrame = aDataFrame["Time"]

fig1, ax1 = plt.subplots()
ax1.set_title('Box Plot')
ax1.boxplot(x=aDataFrame,autorange=True)

plt.show()
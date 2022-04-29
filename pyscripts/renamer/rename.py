import os
import json
import copy

DIR_ROOT = r'F:\data\Tesis\EvolucionAprendizajeTDD\pyscripts\renamer\input'
AG_ADELANTE = '_P'
AG_ATRAS = '_P'
REEMPLAZAR_ANTERIOR = '.st'
REEMPLAZAR_NUEVO = '_P.st'
POS_REPOSITORIO = 0
POS_EJERCICIO = 3
POS_ESTADO = 4
ESTADO_OK = "OK"

dictEstados = {
    "MR":0,
    "TEL":0,
    "PO1":0,
    "PO2":0,
    "TL1":0,
    "TL2":0,
    "TL3":0
}

dictRepositorios = {

}

def ag_adelante():

    directory = os.fsencode(DIR_ROOT)
        
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        rename = DIR_ROOT + '\\' + AG_ADELANTE + filename
        os.rename(DIR_ROOT + '\\' + filename, rename)
        print(rename)


def ag_atras():

    directory = os.fsencode(DIR_ROOT)
        
    for file in os.listdir(directory):
        filename = os.fsdecode(file)        
        rename = DIR_ROOT + '\\' + filename + AG_ATRAS + '.json'
        os.rename(DIR_ROOT + '\\' + filename,rename)
        print(rename)


def reemplazar():

    directory = os.fsencode(DIR_ROOT)
        
    for file in os.listdir(directory):
        filename = os.fsdecode(file)        
        rename = DIR_ROOT + '\\' + filename

        rename = rename.replace(REEMPLAZAR_ANTERIOR,REEMPLAZAR_NUEVO)

        os.rename(DIR_ROOT + '\\' + filename,rename)
        print(rename)

def sumarUnoOrden():

    global REEMPLAZAR_ANTERIOR
    global REEMPLAZAR_NUEVO

    directory = os.fsencode(DIR_ROOT)
        
    for file in os.listdir(directory):
        filename = os.fsdecode(file)        
        rename = DIR_ROOT + '\\' + filename

        nameParts = rename.split('_')
        orden = 1 
        '''int(nameParts[POS_ORDEN])'''
        nuevoOrden = orden + 1
        rename = rename.replace('_'+ str(orden) + '_', '_' + str(nuevoOrden) + '_RRR')        
        os.rename(DIR_ROOT + '\\' + filename,rename)
        print(rename)

    REEMPLAZAR_ANTERIOR = 'RRR'
    REEMPLAZAR_NUEVO = ''
    reemplazar()

def parseJson():

    with open(DIR_ROOT + '\\in.json'  ) as f:
        data = json.load(f)

    print(data)

def contar():

    directory = os.fsencode(DIR_ROOT)
        
    for file in os.listdir(directory):
        
        filename = os.fsdecode(file)
        nameParts = filename.split('_')
        repositorio = nameParts[POS_REPOSITORIO]
        ejercicio = nameParts[POS_EJERCICIO]

        if not repositorio in dictRepositorios:
            dictRepositorios[repositorio] = copy.deepcopy(dictEstados)
                
        if nameParts[POS_ESTADO] == ESTADO_OK:
            dictRepositorios[repositorio][ejercicio] += 1
               
    #Se imprimen los valores
    for r in dictRepositorios:
        print(str(r) + ","  + str(dictRepositorios[r]["MR"]) + ","
                            + str(dictRepositorios[r]["TEL"]) + ","
                            + str(dictRepositorios[r]["PO1"]) + ","
                            + str(dictRepositorios[r]["PO2"]) + ","
                            + str(dictRepositorios[r]["TL1"]) + ","
                            + str(dictRepositorios[r]["TL2"]) + ","
                            + str(dictRepositorios[r]["TL3"]))

#contar()
#ag_adelante()
#ag_atras()
reemplazar()
#sumarUnoOrden()
#parseJson()
import sys
import os
import subprocess
import signal
import math
import cmath
import time
import string
import shutil

title = 'mvsp_macro'
func = {}

ftype = ''
N = '2'
tile = 'N'
flags = ''
falg = ''

radix = [2,4,8]
srcDir = os.getcwd() + '/'
runDir = srcDir.replace("mvsp_src/","") 
dstDir = srcDir.replace("mvsp_src/","mvsp_dst/") 

def main():
    global ftype
    global N
    global tile
    global flags
    global alg

    ftype = sys.argv[1]
    N     = sys.argv[2]
    tile  = sys.argv[3]
    flags = sys.argv[4]
    falg  = sys.argv[5]

    if ftype == 'test':
        goTest()
    elif ftype == 'fft':
        if falg == 'all':
            goCooleyDIF()
            goCooleyDIT()
            goKorn()
            goPease()
            goStockham()
        elif falg == 'cooleyDIF':
            goCooleyDIF()
        elif falg == 'cooleyDIT':
            goCooleyDIT()
        elif falg == 'korn':
            goKorn()
        elif falg == 'pease':
            goPease()
        elif falg == 'stockham':
            goStockham()
        else:
            print "Error in main, unknown algorithm: " + falg
    else:
        print "Error in main, unknown function: " + ftype

def goCooleyDIF():
    global title
    for r in radix:
        k = int(math.log(int(N),r))
        if r**k == int(N):
            title = "mvsp_" + N + "_cooleyDIF" + str(r)
            genKorn(k,r)    
            optFunc()
            genFunc()
            runFunc()

def genCooleyDIF(k,r):
    global func
    func = {}
    func[0] = ('R',(r**k,r) )
    for i in range(k):
        func[i*2 +1] = ('IT',( r**(k-i-1), r**(i+1), r**i ))
        func[i*2 +2] = ('IFI',( r**(k-i-1), r, r**i ))

def goCooleyDIT():
    global title
    for r in radix:
        k = int(math.log(int(N),r))
        if r**k == int(N):
            title = "mvsp_" + N + "_cooleyDIT" + str(r)
            genKorn(k,r)    
            optFunc()
            genFunc()
            runFunc()

def genCooleyDIT(k,r):
    global func
    func = {}
    for i in range(k):
        func[i*2 +0] = ('IT',( r**i, r**(k-i), r**(k-i-1) ))
        func[i*2 +1] = ('IFI',( r**i, r, r**(k-i-1) ))
    func[k*2] = ('R',(r**k,r) )

def goKorn():
    global title
    for r in radix:
        k = int(math.log(int(N),r))
        if r**k == int(N):
            title = "mvsp_" + N + "_korn" + str(r)
            genKorn(k,r)    
            optFunc()
            genFunc()
            runFunc()

def genKorn(k,r):
    global func
    func = {}
    for i in range(k):
        func[i*3 +0] = ('FI',( r, r**(k-1) ))
        func[i*3 +1] = ('TI',( r**(k-i), r**(k-i-1), r**i ))
        func[i*3 +2] = ('L',( r**k, r))
    func[k*3] = ('R',(r**k,r) )

def goPease():
    global title
    for r in radix:
        k = int(math.log(int(N),r))
        if r**k == int(N):
            title = "mvsp_" + N + "_pease" + str(r)
            genKorn(k,r)    
            optFunc()
            genFunc()
            runFunc()

def genPease(k,r):
    global func
    func = {}
    for i in range(k):
        func[i*5 +0] = ('L',( r**k, r))
        func[i*5 +1] = ('IF',( r, r**(k-1) ))
        func[i*5 +2] = ('L',( r**k, r**(k-1)))
        func[i*5 +3] = ('TI',( r**(k-i), r**(k-i-1), r**i ))
        func[i*5 +4] = ('L',( r**k, r))
    func[k*5] = ('R',(r**k,r) )

def goStockham():
    global title
    for r in radix:
        k = int(math.log(int(N),r))
        if r**k == int(N):
            title = "mvsp_" + N + "_stockham" + str(r)
            genStockham(k,r)    
            optFunc()
            genFunc()
            runFunc()

def genStockham(k,r):
    global func
    func = {}
    for i in range(k):
        func[i*3 +0] = ('FI',( r, r**(k-1) ))
        func[i*3 +1] = ('TI',( r**(k-i), r**(k-i-1), r**i ))
        func[i*3 +2] = ('LI',( r**(k-i), r, r**i ))


def goTest():
    parseTest()
    optFunc()
    genTitle()
    genFunc()
    runFunc()
    
def parseTest():
    arg= 5
    count = 0

    param1 = ['F','FR','C','S']
    param2 = [ 'IF', 'FI', 'T', 'L', 'R']
    param3 = [ 'IFI', 'IT', 'TI', 'IL', 'LI' ]

    while arg < len(sys.argv):
        curr = sys.argv[arg]
        if curr in param3:
            value = (int(sys.argv[arg+1]), int(sys.argv[arg+2]), int(sys.argv[arg+3]))
            func[count] = (curr, value)
            arg = arg + 4
            count = count + 1
        elif curr in param2:
            value = (int(sys.argv[arg+1]), int(sys.argv[arg+2]))
            func[count] = (curr, value)
            arg = arg + 3
            count = count + 1
        elif curr in param1:
            value = int(sys.argv[arg+1])
            func[count] = (curr, value)
            arg = arg + 2
            count = count + 1
        else:
            print "Unknown function found in parseTest: " + curr
            break

def genTitle():
    global title
    title = "mvsp"

    for i in range(len(func)):
        arg= func[i][1]
        if func[i][0] == 'LI':
            title = title + "_L" + str(arg[0]) + "_" + str(arg[1]) + "xI" + str(arg[2])
        elif func[i][0] == 'IL':
            title = title + "_I" + str(arg[0]) + "xL" + str(arg[1]) + "_" + str(arg[2])
        elif func[i][0] == 'L':
            title = title + "_L" + str(arg[0]) + "_" + str(arg[1])
        elif func[i][0] == 'TI':
            title = title + "_T" + str(arg[0]) + "_" + str(arg[1]) + "xI" + str(arg[2])
        elif func[i][0] == 'IT':
            title = title + "_I" + str(arg[0]) + "xT" + str(arg[1]) + "_" + str(arg[2])
        elif func[i][0] == 'T':
            title = title + "_T" + str(arg[0]) + "_" + str(arg[1])
        elif func[i][0] == 'IFI':
            title = title + "_I" + str(arg[0]) + "xF" + str(arg[1]) + "xI" + str(arg[2])
        elif func[i][0] == 'IF':
            title = title + "_I" + str(arg[0]) + "xF" + str(arg[1])
        elif func[i][0] == 'FI':
            title = title + "_F" + str(arg[0]) + "xI" + str(arg[1])
        elif func[i][0] == 'F':
            title = title + "_F" + str(arg)
        elif func[i][0] == 'FR':
            title = title + "_FR" + str(arg)
        elif func[i][0] == 'R':
            title = title + "_R" + str(arg[0]) + "_" + str(arg[1])
        else:
            print "Parsing error in genTitle: " + func[i][0]
            break

    return title[1:]
    
def optFunc():
    global func

    #print "Pre opt"
    #for f in func: 
        #print func[f]

    func2={}
    index = 0
    for i in range(len(func)):
        arg= func[i][1]
        f = func[i][0]
        if f in ['LI','TI','L','T','R']:
            if arg[0] == arg[1] or arg[1] == 1:
                index=index-1
            elif f == 'TI' and arg[2] == 1:
                func2[index] = ('T',arg[:-1])
            elif f == 'LI' and arg[2] == 1:
                func2[index] = ('L',arg[:-1])
            else:
                func2[index] = func[i]
                
        elif f == 'FI':
            if arg[1] == 1:
                func2[index] = ('F',arg[0])
            else:
                func2[index] = func[i]

        elif f == 'IT':
            if arg[0] == 1:
                func2[index] = ('T',arg[1:])
            else:
                func2[index] = func[i]

        elif f == 'IL':
            if arg[0] == 1:
                func2[index] = ('L',arg[1:])
            else:
                func2[index] = func[i]

        elif f == 'IF':
            if arg[0] == 1:
                func2[index] = ('F',arg[1])
            else:
                func2[index] = func[i]

        elif f == 'IFI':
            if arg[0] == 1:
                if arg[2] == 1:
                    func2[index] = ('F',arg[1])
                else:
                    func2[index] = ('FI',arg[1:])
            elif arg[2] == 1:
                func2[index] = ('IF',arg[:-1])
            else:
                func2[index] = func[i]

        elif f == 'FR':
            func2[index] = func[i]


        else:
            print "Parsing error in optFunc: " + f
            break
        index=index+1

    func = func2
    #print "Post opt"
    #for f in func: 
        #print func[f]
    #print "\n"

def genFunc():
    gen=open(title+".c",'w')
    gen=open(title+".c",'w')
    gen.write("//VectorBlox 2012\n")
    gen.write("//"+title+"\n\n")
    gen.write('#include "'+title+'.h"\n\n')
    repeated = genRepeat(func)
    writeTmacros(gen)

    for i in range(len(func)):
        if func[i][0] == 'LI':
            if not repeated[i]:
                genLxI( func[i][1],gen)
        elif func[i][0] == 'IL':
            if not repeated[i]:
                genIxL( func[i][1],gen)
        elif func[i][0] == 'L':
            if not repeated[i]:
                genL( func[i][1],gen)
        elif func[i][0] == 'TI':
            if not repeated[i]:
                genTxI( func[i][1],gen)
        elif func[i][0] == 'IT':
            if not repeated[i]:
                genIxT( func[i][1],gen)
        elif func[i][0] == 'T':
            if not repeated[i]:
                genT( func[i][1],gen)
        elif func[i][0] == 'IFI':
            if not repeated[i]:
                genIxFxI( func[i][1],gen)
        elif func[i][0] == 'IF':
            if not repeated[i]:
                genIxF( func[i][1],gen)
        elif func[i][0] == 'FI':
            if not repeated[i]:
                genFxI( func[i][1],gen)
        elif func[i][0] == 'F':
            if not repeated[i]:
                genF( func[i][1],gen)
        elif func[i][0] == 'FR':
            if not repeated[i]:
                genFR( func[i][1],gen)
        elif func[i][0] == 'R':
            if not repeated[i]:
                genR( func[i][1],gen)
        else:
            print "Parsing error in genFunc @ " +str(i)+ ": " + func[i][0]
            break

    writeFunc(func,gen)
    gen.close()

    head = open( title + ".h",'w')
    writeHead(head)
    head.close()

def genRepeat(func):
    repeated = {}
    for key in range(len(func)):
        repeated[key]=0

    for key in range(len(func)):
        for key2 in range(len(func)):
            if key2 > key and func[key] == func[key2]:
                repeated[key2] = 1
    return repeated

def writeHead(head):
    head.write("//VectorBlox 2012\n")
    head.write("//"+title+"\n\n")
    head.write('#include "vbx.h"\n')
    head.write('#include "vbx_port.h"\n')
    head.write('#include "vbx_common.h"\n')
    head.write("\n")
    head.write("#define N "+N+"\n")
    head.write("#define TILE "+tile+"\n")
    head.write("#define N2 N*TILE\n")
    if 'd' in flags:
        head.write("#define DEBUG 1\n")
    else:
        head.write("#define DEBUG 0\n")
    head.write("\n")
    name = "int "+ title + "(vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)"
    head.write(name+";\n")

def writeFunc(func,gen):
    inY = False
    yx = "yr, yi, xr, xi);\n"
    xy = "xr, xi, yr, yi);\n"
    yt = "yr, yi, xr);\n"
    xt = "xr, xi, yr);\n"
    name = "int "+ title + "(vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)"
    gen.write(name + "\n{\n")

    for i in reversed(range(len(func))):
        arg = func[i][1]
        if func[i][0] == 'LI':
            gen.write("\tL"+str(arg[0])+"_"+str(arg[1])+"xI("+str(arg[2])+",")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'IL':
            gen.write("\tIxL"+str(arg[1])+"_"+str(arg[2])+"("+str(arg[0])+",")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'L':
            gen.write("\tL"+str(arg[0])+"_"+str(arg[1])+"(")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'TI':
            gen.write("\tT"+str(arg[0])+"_"+str(arg[1])+"xI("+str(arg[2])+",")
            if inY:
                gen.write(yt)
            else:
                gen.write(xt)
        elif func[i][0] == 'IT':
            gen.write("\tIxT"+str(arg[1])+"_"+str(arg[2])+"("+str(arg[0])+",")
            if inY:
                gen.write(yt)
            else:
                gen.write(xt)
        elif func[i][0] == 'T':
            gen.write("\tT"+str(arg[0])+"_"+str(arg[1])+"(")
            if inY:
                gen.write(yt)
            else:
                gen.write(xt)
        elif func[i][0] == 'IFI':
            gen.write("\tIxF"+str(arg[1])+"xI("+str(arg[0])+","+str(arg[2])+",")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'IF':
            gen.write("\tIxF"+str(arg[1])+"("+str(arg[0])+",")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'FI':
            gen.write("\tF"+str(arg[0])+"xI("+str(arg[1])+",")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        elif func[i][0] == 'F':
            gen.write("\tF"+str(arg)+"(")
            gen.write(yx)
            inY = not inY
        elif func[i][0] == 'FR':
            gen.write("\tFR"+str(arg)+"(")
            gen.write(yx)
            inY = not inY
        elif func[i][0] == 'R':
            gen.write("\tR"+str(arg[0])+"_"+str(arg[1])+"(")
            if inY:
                gen.write(xy)
            else:
                gen.write(yx)
            inY = not inY
        else:
            print "Parsing Error in writeFunc: " + func[i][0]
            break
    if not inY:
        gen.write("\treturn 1;\n")
    else:
        gen.write("\treturn 0;\n")
    gen.write("}\n\n")

def writeTmacros(gen):
    macro=open( "Tmacros.h",'r' )
    line=macro.readline()
    while "def" not in line:
        line=macro.readline()
    while line:
        gen.write(line)
        line=macro.readline()
    gen.write("\n")
    macro.close()

def genT(arg,gen):
    gen.write("static inline void T"+ str(arg[0])+ "_" + str(arg[1]) + "(vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* tt )\n")
    gen.write("{\n")
    gen.write("\tvbx_set_vl(TILE);\n")

    lastT4 = False
    lastTN = False

    for x in range(int(arg[0]/arg[1])):
        for y in range(arg[1]):
            pair = cmath.exp(-2j*math.pi*x*y/arg[0])
            rp = int(round(pair.real*(2**15)))
            ip = int(round(pair.imag*(2**15)))
            if rp == 32768:
                pass
            elif ip == -32768:
                gen.write("\tT1( " + str(y+x*arg[1]) + ",    " + str(rp) + ", " +str(ip) + ", 0,1);\n")
            elif rp == 23170:
                gen.write("\tT4p(" + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,1);\n")
                else:
                    gen.write("1,2,1);\n")
                lastT4 = not lastT4
            elif rp == -23170:
                gen.write("\tT4n(" + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,1);\n")
                else:
                    gen.write("1,2,1);\n")
                lastT4 = not lastT4
            else:
                gen.write("\tTN( " + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastTN:
                    gen.write("9,10,11,12,1);\n")
                else:
                    gen.write("5,6,7,8,1);\n")
                lastTN = not lastTN
    gen.write("}\n\n")

def genL(arg,gen):
    gen.write("static inline void L"+ str(arg[0])+ "_" + str(arg[1]) + "(vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)\n")
    gen.write("{\n")
    gen.write("\tvbx_set_2D(" + str(arg[0]/arg[1]) + ", TILE*sizeof(short), " + str(arg[1]) + "*TILE*sizeof(short), 0);\n")
    gen.write("\tvbx_set_vl(TILE);\n")
    for i in range(arg[1]):
        gen.write("\tvbx_2D(VVH, VMOV, yr+"+str(i)+"*TILE*"+str(arg[0]/arg[1])+", xr+TILE*"+str(i)+", 0);\n")
        gen.write("\tvbx_2D(VVH, VMOV, yi+"+str(i)+"*TILE*"+str(arg[0]/arg[1])+", xi+TILE*"+str(i)+", 0);\n")
    gen.write("}\n\n")

def getRev(N,r):
    k= int(math.log(N,r))
    rev = {}
    for n in range(N):
        nr = 0
        for i in range(k):
            nr = nr + ((n/(r**i)) % r) * r**(k-i-1)
        rev[n] = nr
    return rev

def genR(arg,gen):
    gen.write("static inline void R"+ str(arg[0])+ "_" + str(arg[1]) + "(vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)\n")
    gen.write("{\n")
    gen.write("\tvbx_set_vl(TILE);\n")
    rev = getRev(arg[0],arg[1])
    for i in range(len(rev)):
        gen.write("\tvbx(VVH, VMOV, yr+TILE*"+str(rev[i])+", xr+TILE*"+str(i)+", 0);\n")
        gen.write("\tvbx(VVH, VMOV, yi+TILE*"+str(rev[i])+", xi+TILE*"+str(i)+", 0);\n")
    gen.write("}\n\n")

def genF(arg,gen):
    kern=open( "F"+str(arg)+"kernel.h",'r' )

    line=kern.readline()
    while "void" not in line:
        line=kern.readline()

    while "}" not in line:
        gen.write(line)
        line=kern.readline()

    gen.write("}\n\n")
    kern.close()

def genFR(arg,gen):
    kern=open( "FR"+str(arg)+"kernel.h",'r' )

    line=kern.readline()
    while "void" not in line:
        line=kern.readline()

    while "}" not in line:
        gen.write(line)
        line=kern.readline()

    gen.write("}\n\n")
    kern.close()

def genIxF(arg,gen):
    kern=open( "F"+str(arg[1])+"kernel.h",'r' )

    line=kern.readline()
    while "void" not in line:
        line=kern.readline()

    gen.write("static inline void IxF"+ str(arg[1])+ "(short n, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi )\n")
    line=kern.readline()
    gen.write(line) #should be brackets

    gen.write("\tvbx_set_2D(n, "+str(arg[1])+"*TILE*sizeof(short), "+str(arg[1])+"*TILE*sizeof(short), "+str(arg[1])+"*TILE*sizeof(short));\n")
    line=kern.readline()
    gen.write(line)# should be vbx_set_vl
    line=kern.readline()

    while "}" not in line:
        line=line.replace("vbx", "vbx_2D")
        gen.write(line)
        line=kern.readline()

    gen.write("}\n\n")
    kern.close()

def genFxI(arg,gen):
    kern=open( "F"+str(arg[0])+"kernel.h",'r' )

    line=kern.readline()
    while "void" not in line:
        line=kern.readline()

    gen.write("static inline void F"+ str(arg[0])+ "xI(short m, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi )\n")
    line=kern.readline()
    gen.write(line) #should be brackets
    line=kern.readline()
    gen.write("\tvbx_set_vl(TILE*m);\n")
    line=kern.readline()

    while "}" not in line:
        line=line.replace("TILE", "TILE*m")
        gen.write(line)
        line=kern.readline()

    gen.write("}\n\n")
    kern.close()

def genIxFxI(arg,gen):
    kern=open( "F"+str(arg[1])+"kernel.h",'r' )

    line=kern.readline()
    while "void" not in line:
        line=kern.readline()

    gen.write("static inline void IxF"+ str(arg[1])+ "xI(short n, short m, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi )\n")
    line=kern.readline()
    gen.write(line) #should be brackets
    line=kern.readline()
    gen.write("\tvbx_set_2D(n, "+ str(arg[1])+ "*TILE*m*sizeof(short), "+ str(arg[1])+ "*TILE*m*sizeof(short), "+ str(arg[1])+ "*TILE*m*sizeof(short));\n")
    gen.write("\tvbx_set_vl(TILE*m);\n")
    line=kern.readline()

    while "}" not in line:
        line=line.replace("TILE", "TILE*m")
        line=line.replace("vbx", "vbx_2D")
        gen.write(line)
        line=kern.readline()

    gen.write("}\n\n")
    kern.close()

def genTxI(arg,gen):
    gen.write("static inline void T"+ str(arg[0])+ "_" + str(arg[1]) + "xI(short m, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* tt )\n")
    gen.write("{\n")
    gen.write("\tvbx_set_vl(TILE*m);\n")

    lastT4 = False
    lastTN = False

    for x in range(int(arg[0]/arg[1])):
        for y in range(arg[1]):
            pair = cmath.exp(-2j*math.pi*x*y/arg[0])
            rp = int(round(pair.real*(2**15)))
            ip = int(round(pair.imag*(2**15)))
            if rp == 32768:
                pass
            elif ip == -32768:
                gen.write("\tT1( " + str(y+x*arg[1]) + ",    " + str(rp) + ", " +str(ip) + ", 0,m);\n")
            elif rp == 23170:
                gen.write("\tT4p(" + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,m);\n")
                else:
                    gen.write("1,2,m);\n")
                lastT4 = not lastT4
            elif rp == -23170:
                gen.write("\tT4n(" + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,m);\n")
                else:
                    gen.write("1,2,m);\n")
                lastT4 = not lastT4
            else:
                gen.write("\tTN( " + str(y+x*arg[1]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastTN:
                    gen.write("9,10,11,12,m);\n")
                else:
                    gen.write("5,6,7,8,m);\n")
                lastTN = not lastTN
    gen.write("}\n\n")

def genLxI(arg,gen):
    gen.write("static inline void L"+ str(arg[0])+ "_" + str(arg[1]) + "xI( short m, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)\n")
    gen.write("{\n")
    gen.write("\tvbx_set_2D(" + str(arg[0]/arg[1]) + ", TILE*m*sizeof(short), " + str(arg[1]) + "*TILE*m*sizeof(short), 0);\n")
    gen.write("\tvbx_set_vl(TILE*m);\n")
    for i in range(arg[1]):
        gen.write("\tvbx_2D(VVH, VMOV, yr+"+str(i)+"*TILE*m*"+str(arg[0]/arg[1])+", xr+TILE*m*"+str(i)+", 0);\n")
        gen.write("\tvbx_2D(VVH, VMOV, yi+"+str(i)+"*TILE*m*"+str(arg[0]/arg[1])+", xi+TILE*m*"+str(i)+", 0);\n")
    gen.write("}\n\n")

def genIxT(arg,gen):
    gen.write("static inline void IxT"+ str(arg[1])+ "_" + str(arg[2]) + "(short n, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* tt )\n")
    gen.write("{\n")
    gen.write("\tvbx_set_2D( n , "+ str(arg[1])+"*TILE*sizeof(short), "+ str(arg[1])+"*TILE*sizeof(short), "+ str(arg[1])+"*TILE*sizeof(short));\n")
    gen.write("\tvbx_set_vl(TILE);\n")

    lastT4 = False
    lastTN = False

    for x in range(int(arg[1]/arg[2])):
        for y in range(arg[2]):
            pair = cmath.exp(-2j*math.pi*x*y/arg[1])
            rp = int(round(pair.real*(2**15)))
            ip = int(round(pair.imag*(2**15)))
            if rp == 32768:
                pass
            elif ip == -32768:
                gen.write("\tT1_2D( " + str(y+x*arg[2]) + ",    " + str(rp) + ", " +str(ip) + ", 0,1);\n")
            elif rp == 23170:
                gen.write("\tT4p_2D(" + str(y+x*arg[2]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,1);\n")
                else:
                    gen.write("1,2,1);\n")
                lastT4 = not lastT4
            elif rp == -23170:
                gen.write("\tT4n_2D(" + str(y+x*arg[2]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastT4:
                    gen.write("3,4,1);\n")
                else:
                    gen.write("1,2,1);\n")
                lastT4 = not lastT4
            else:
                gen.write("\tTN_2D( " + str(y+x*arg[2]) + "," + str(rp) + ", " +str(ip) + ", ")
                if lastTN:
                    gen.write("9,10,11,12,1);\n")
                else:
                    gen.write("5,6,7,8,1);\n")
                lastTN = not lastTN
    gen.write("}\n\n")

def genIxL(arg,gen):
    gen.write("static inline void IxL"+ str(arg[1])+ "_" + str(arg[2]) + "(short n, vbx_half_t* yr, vbx_half_t* yi, vbx_half_t* xr, vbx_half_t* xi)\n")
    gen.write("{\n")
    gen.write("\tvbx_set_3D( n , "+ str(arg[1])+"*TILE*sizeof(short), "+ str(arg[1])+"*TILE*sizeof(short), "+ str(arg[1])+"*TILE*sizeof(short));\n")
    gen.write("\tvbx_set_2D(" + str(arg[1]/arg[2]) + ", TILE*sizeof(short), " + str(arg[2]) + "*TILE*sizeof(short), 0);\n")
    gen.write("\tvbx_set_vl(TILE);\n")
    for i in range(arg[2]):
        gen.write("\tvbx_3D(VVH, VMOV, yr+"+str(i)+"*TILE*"+str(arg[1]/arg[2])+", xr+TILE*"+str(i)+", 0);\n")
        gen.write("\tvbx_3D(VVH, VMOV, yi+"+str(i)+"*TILE*"+str(arg[1]/arg[2])+", xi+TILE*"+str(i)+", 0);\n")
    gen.write("}\n\n")

def runFunc():
    runTitle = title
    runTitle = 'mvsp_macro'

    if not os.path.exists(dstDir):
        os.mkdir(dstDir)
    os.rename( srcDir + title + ".h", dstDir + title + ".h")
    os.rename( srcDir + title + ".c", dstDir + title + ".c")
    shutil.copyfile( dstDir + title + ".h", runDir + runTitle + ".h")
    shutil.copyfile( dstDir + title + ".c", runDir + runTitle + ".c")

    mvsp = file( runDir + "mvsp.c", 'r' )
    mvsp2 = file( runDir + "mtmp", 'w')
    for line in mvsp:
        if '#include' in line and 'mv' in line:
             mvsp2.write('#include "' + runTitle + '.h"\n')
        elif 'swap' in line and 'mv' in line:
             mvsp2.write('\tshort swap = ' + runTitle + '(v_yr,v_yi,v_xr,v_xi);\n')
        else:
             mvsp2.write(line)
    mvsp.close()
    mvsp2.close()
    os.remove( runDir + "mvsp.c")
    os.rename( runDir + "mtmp", runDir + "mvsp.c")

    msrc = file( runDir + runTitle + ".c", 'r' )
    msrc2 = file( runDir + "mtmp", 'w')
    for line in msrc:
        if title in line:
             line=line.replace(title,runTitle)
        msrc2.write(line)
    msrc.close()
    msrc2.close()
    os.remove( runDir + runTitle + ".c")
    os.rename( runDir + "mtmp", runDir + runTitle + ".c")

    mhead = file( runDir + runTitle + ".h", 'r' )
    mhead2 = file( runDir + "mtmp", 'w')
    for line in mhead:
        if title in line:
             line=line.replace(title,runTitle)
        mhead2.write(line)
    mhead.close()
    mhead2.close()
    os.remove( runDir + runTitle + ".h")
    os.rename( runDir + "mtmp", runDir + runTitle + ".h")

    csrc = file( runDir + "sources.mk", 'r' )
    csrc2 = file( runDir + "ctmp", 'w')
    for line in csrc:
        if 'mvsp' in line and 'mvsp.c' not in line:
             csrc2.write('C_SRCS += ' + runTitle + '.c\n')
        else:
             csrc2.write(line)
    csrc.close()
    csrc2.close()
    os.remove( runDir + "sources.mk")
    os.rename( runDir + "ctmp", runDir + "sources.mk")

    temp = file( runDir + 'output.txt', 'w' )
    temp.close()

    os.chdir(runDir)
    subprocess.check_call( ["make", "clean"] )
    subprocess.check_call( "make" )
    subprocess.check_call( ["nios2-download", "-g", "-c", "USB-Blaster [2-1.1]", "test.elf"] )

    if 's' in flags:
        cmd2 = 'nios2-terminal -c "USB-Blaster [2-1.1]" | tee "output.txt"'
    else:
        cmd2 = 'nios2-terminal -c "USB-Blaster [2-1.1]" > "output.txt"'
    proc2 = subprocess.Popen(cmd2,shell=True )
    proc2.wait()

    output=open( runDir + "output.txt",'r')
    if os.path.isfile(dstDir+ "master.txt"):
        master=open( dstDir + "master.txt",'a')
    else:
        master=open( dstDir + "master.txt",'w')
        master.write("MSPS\t\tN\t\tTILE\tFUNCTION\n")

    line=output.readline()
    while line:
        if 'MSPS' in line:
            result = line[:-6] + "\t"
            result = result + N + "\t\t"
            result = result + tile + "\t\t"
            result = result + title + "\n"
            master.write(result)
            print "\n" + result
        line = output.readline()
    output.close()
    master.close()
    os.chdir(srcDir)

if __name__ == "__main__":
    main()

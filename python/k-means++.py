import scipy
from numpy import loadtxt
import numpy as np
import pylab

def kmeansplusplus(X, K):
    raw_input("\n##########start k-means++ initialize###########")
    c = X[0].tolist()
    pylab.scatter(c[0],c[1],color='g',marker='s',s=50)
    C = [c]
    for k in range(1, K):
        raw_input("Iter "+str(k))
        i = k
        D2 = np.array([min([np.inner(c-x,c-x) for c in C]) for x in X])
        probs = 1.0 * D2/D2.sum()
        cumprobs = probs.cumsum()
        r = scipy.rand()
        print "distance={D2}\nprobs={probs}\nrandomValue={r}".format(D2=D2,probs=probs,r=r)
        #print "point\tprob"
        for j,p in enumerate(cumprobs):
            #print "{}\t{}".format(j,p)
            if r < p:
                i = j
                break
        c = X[i].tolist()
        pylab.scatter(c[0],c[1],color='g',marker='s',s=50)
        print "add to C: " + str(c)
        C.append(c)
    return C

def kmeansparallel(X, K, l, iters):
    raw_input("\n##########start k-means|| initialize###########")
    c = X[0].tolist()
    pylab.scatter(c[0],c[1],c='r')
    C = [c]
    for k in range(iters):
        raw_input("Iter "+str(k))
        D2 = np.array([min([np.inner(c-x,c-x) for c in C]) for x in X])
        probs = 1.0 * D2/D2.sum()
        print "distance={D2}\nprobs={probs}\n".format(D2=D2,probs=probs)
        #print "point\tprob"
        for j,p in enumerate(probs):
            #print "{}\t{}".format(j,p)
            r = scipy.rand()
            if r < p*l:
                c = X[j].tolist()
                pylab.scatter(c[0],c[1],color='r')
                print "add to C: " + str(c)
                C.append(c)
    return kmeansplusplus(np.array(C),K)

if __name__ == '__main__':
    pylab.ion()
    X = loadtxt("k-means.txt")
    pylab.scatter(X[:,:1],X[:,1:2])
    choice = input('1)k-means++\n2)k-means||\n') 
    k=input('k=')
    C = []
    if choice == 1:
        C = kmeansplusplus(X,k)
    else:
        C = kmeansparallel(X,k,0.6*k,8)
    print "\nAfter initialize:"
    print C
#4 задача 
create_Graf <- function(n) {
 M <- matrix(data = 0, nrow = n, ncol = n)
  return(M)
}
addEdge <- function(M, v1, v2, p){
if (v1 > 0 && v2 > 0 && v1!=v2 && v1<=dim(M)[1] && v2<=dim(M)[1]) {
M[v1, v2] = p
M[v2, v1] = p
  return(M)
} else {
  print('ERROR')
  return(M)
 }
}

removeEdge <- function(M, v1, v2){
  if (v1 > 0 && v2 > 0 && v1!=v2 && v1<=dim(M)[1] && v2<=dim(M)[1]) {
    M[v1, v2] = 0
    M[v2, v1] = 0
    return(M)
  } else {
    print('ERROR')
    return(M)
  }
}
addVer <- function(M) {
  N = ncol(M)
  M <- rbind(M, 0)
  M <- cbind(M, 0)
  return(M)
}
removeVer <- function(M, V){
  M <- M[-V, -V]
  return(M)
}
listVer <- function(M, V){
  return(which(M[V,] != 0))
}
G = create_Graf(11)
G = addEdge(G, 1, 4, 1)
G = addEdge(G, 2, 3, 1)
G = removeEdge(G, 2, 2)
G = addVer(G)
G = removeVer(G, 2)
G = addEdge(G, 2, 1, 1)
G = addEdge(G, 3, 2, 1)
G = addEdge(G, 1, 4, 1)
G = addEdge(G, 5, 1, 1)
G = addEdge(G, 9, 3, 1)
G = addEdge(G, 1, 8, 1)
G = addEdge(G, 4, 8, 1)
G = addEdge(G, 7, 2, 1)
G = addEdge(G, 7, 1, 1)
G = addEdge(G, 6, 8, 1)
G = addEdge(G, 6, 9, 1)
G = addEdge(G, 9, 10, 1)
G = addEdge(G, 8, 9, 1)
G = addEdge(G, 8, 7, 1)
G = addEdge(G, 6, 7, 1)
G = addEdge(G, 5, 10, 1)
G = addEdge(G, 5, 9, 1)
G = addEdge(G, 5, 8, 1)
G = addEdge(G, 5, 7, 1)
G = addEdge(G, 5, 6, 1)
G = addEdge(G, 10, 2, 1)
G = addEdge(G, 9, 1, 1)
G = addEdge(G, 8, 1, 1)
G = addEdge(G, 7, 1, 1)
G = addEdge(G, 6, 1, 1)
G = addEdge(G, 11, 1, 1)
G = addEdge(G, 12, 11, 1)
print(listVer(G, 3))
print(G)
#5 задача
potomki <- function(M, V) {
  R = M[,V]
  for (L in 2:(length(R)-1)) {
    for(i in 1:length(R)) {
      if(R[i]==(L-1)) {
        Adj=listVer(M, i)
        for(j in 1:length(Adj)) {
          if(Adj[j]!=V)
            if(R[Adj[j]]<1) {
              R[Adj[j]]=L
            }
        }
      }
    }
  }
  return(R)
}
print(potomki(G, 1))

GG=graph_from_adjacency_matrix(G,weighted=NULL,mode=c("undirected"))
plot.igraph(GG)
#6 задача 

volna <- function(M, V1, V2) {
  L <- potomki(M, V1)
  route=c()
  if (L[V2] == 0) {
    break
  } else {
    if (L[V2] == 1) {
     route <- c(V1, V2)
    } else {
     route <- c(V2, route)
      for (i in L[V2]:2) {
        for (j in which(L == (i - 1))) {
          if (M[j, V2] != 0) {
          route <- c(j, route)
            V2 = j
            break
          }
        }
      }
     route <- c(V1, route)
    }
  }
  
  return(route)
}

print(volna(G, 10, 11))
#7 задача 

ds <- function(M,V1,V2,vis=rep(0,length(M[1,]))){
  vis[V1]=1
  if (M[V1,V2]>0) {
    Res=c(V1, V2)
    return(Res)
  } else {
    AL=listVer(M,V1)
    Res=c()
    for (i in AL) {
      if (vis[i]==0) {
        R=ds(M,i,V2,vis)
        if (length(R)>0) {
          Res=c(V1,R)
          return(Res)
        }
      }
    }
    return(Res)
  }
}
print(ds(G,11,6,vis=rep(0,length(G[1,]))))
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector <vector <int>> ady;
vector <bool> vis;

long long pares = 0;
long long impares = 0;

void dfs(int nodo, bool paridad) {
    vis[nodo] = true;
    if (paridad) {
        pares++;
    } else {
        impares++;
    }
    for (int vecino : ady[nodo]) {
        if (!vis[vecino]) {
            dfs(vecino, !paridad); 
        }
    }
}

int main(){    
    long long nodos;
    
    std::cin >> nodos;

    ady.resize(nodos+1);
    vis.resize(nodos+1, false);

    if (nodos < 2){
         std::cout << "0";
         return 0;
    }else {
        for (int i = 0; i < nodos - 1; i++) {
            long long u, v;
            std::cin >> u >> v;
            ady[u].push_back(v);
            ady[v].push_back(u);
        }

        dfs(1, true);

        long long res = (pares) * impares - (nodos - 1);

        std::cout << res;
    }

    
    return 0;

}
#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

void bfs_custom(const std::vector<std::pair<int,int>>& grafo, long long aulas, long long res[]) {

    long long nivel = 0;

    bool visitados[aulas];
    std::fill_n(visitados, aulas, false);

    std::queue<long long> cola;
    cola.push(1); 
    visitados[0] = true; 

    while (!cola.empty()) {
        int size = cola.size();

        for (int i = 0; i < size; i++) {
            long long nodo_actual = cola.front();
            cola.pop();
            long long pos_nodo = nodo_actual - 1; 
            res[pos_nodo] = nivel; 

            long long anterior = nodo_actual - 1; 

            if (anterior >= 1 && !visitados[anterior - 1]) {
                cola.push(anterior);
                visitados[anterior - 1] = true; 
            }

            long long siguiente = nodo_actual + 1; 

            if (siguiente <= aulas && !visitados[siguiente - 1]) {
                cola.push(siguiente);
                visitados[siguiente - 1] = true; 
            }

            long long atajo = grafo[pos_nodo].second;

            if (atajo <= aulas && !visitados[atajo - 1]) {
                cola.push(atajo);
                visitados[atajo - 1] = true; 
            }
        }

        nivel+=1;
    }
}

int main() {
    long long aulas;
    std::cin >> aulas;
    std::vector<std::pair<int,int>> grafo(aulas); 
    long long res[aulas];

    for (int i = 1; i <= aulas; i++) {
        long long atajo;
        std::cin >> atajo; 
        grafo[i - 1] = {i, atajo}; 
    }

    std::fill_n(res, aulas, -1);

    bfs_custom(grafo, aulas, res);

    for (int i = 0; i < aulas; ++i) {
        std::cout << res[i] << " ";
    }

}
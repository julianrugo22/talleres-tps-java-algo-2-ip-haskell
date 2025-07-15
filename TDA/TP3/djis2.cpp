#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

struct Arista {
    int destino, peso;
};

long long dijkstra(int inicio, int fin, int n, vector<vector<Arista>>& grafo, vector<long long>& distancia) {
    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<>> cola_prioridad;

    distancia[inicio] = 0;
    cola_prioridad.push({0, inicio});

    while (!cola_prioridad.empty()) {
        auto [dist, actual] = cola_prioridad.top();
        cola_prioridad.pop();

        if (dist > distancia[actual]) continue;

        for (const auto& arista : grafo[actual]) {
            int vecino = arista.destino;
            long long nueva_distancia = dist + arista.peso;

            if (nueva_distancia < distancia[vecino]) {
                distancia[vecino] = nueva_distancia;
                cola_prioridad.push({nueva_distancia, vecino});
            }
        }
    }

    return distancia[fin];
}

long long calcularCosto(int inicio, int fin, int n, vector<vector<Arista>>& grafo, const vector<long long>& distancia) {
    long long costo_total = 0;

    for (int u = 0; u < n; u++) {
        for (const auto& arista : grafo[u]) {
            int v = arista.destino;
            int peso = arista.peso;

            if (distancia[u] + peso == distancia[v]) {
                costo_total += peso;
            }
        }
    }

    return costo_total;
}

int main() {
    int n, m;
    cin >> n >> m;

    vector<vector<Arista>> grafo(n);

    for (int i = 0; i < m; i++) {
        int origen, destino, peso;
        cin >> origen >> destino >> peso;

        grafo[origen].push_back({destino, peso});
        grafo[destino].push_back({origen, peso});
    }

    vector<long long> distancia(n, LLONG_MAX);
    dijkstra(0, n - 1, n, grafo, distancia);

    long long costo_total = calcularCosto(0, n - 1, n, grafo, distancia);

    cout << costo_total * 2 << endl;

    return 0;
}
